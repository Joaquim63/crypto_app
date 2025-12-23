import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_app/presentation/viewmodels/details_viewmodel.dart';
import 'package:crypto_app/presentation/widgets/error_message_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class DetailsPage extends ConsumerWidget {
  final String cryptoId;

  const DetailsPage({super.key, required this.cryptoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // detailsViewModelState agora é AsyncValue<DetailsPageState>
    final detailsViewModelState = ref.watch(detailsViewModelProvider(cryptoId));
    final detailsViewModel = ref.read(
      detailsViewModelProvider(cryptoId).notifier,
    );

    // Observa o estado de favorito para esta criptomoeda
    final isFavoriteState = detailsViewModelState.when(
      data: (pageState) => pageState.isFavorite,
      loading: () => const AsyncValue.loading(),
      error: (err, stack) => AsyncValue.error(err, stack),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Criptomoeda'),
        actions: [
          isFavoriteState.when(
            data: (isFav) => IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : null,
              ),
              onPressed: () => detailsViewModel.toggleFavorite(),
            ),
            loading: () =>
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            error: (error, stack) => IconButton(
              icon: const Icon(Icons.error, color: Colors.red),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Erro ao verificar favorito: ${error.toString()}',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: detailsViewModelState.when(
        data: (pageState) {
          final crypto = pageState.cryptoDetails.value;

          if (crypto == null) {
            return const Center(child: Text('Criptomoeda não encontrada.'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crypto.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  crypto.symbol.toUpperCase(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(
                  'Preço Atual: \$${crypto.currentPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Variação 24h: ${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: crypto.priceChangePercentage24h >= 0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                Text(
                  'Volume de Mercado: \$${crypto.marketCap.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                Text(
                  'Gráfico de Preço (24h)',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Gráfico de exemplo (requer dados reais de histórico para ser funcional)
                SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                          color: const Color(0xff37434d),
                          width: 1,
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            const FlSpot(0, 1),
                            const FlSpot(1, 1.5),
                            const FlSpot(2, 1.4),
                            const FlSpot(3, 2),
                            const FlSpot(4, 1.8),
                            const FlSpot(5, 2.2),
                            const FlSpot(6, 2.5),
                          ],
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Descrição',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                const Text(
                  'Esta é uma descrição detalhada da criptomoeda. '
                  'Aqui você encontraria informações sobre o projeto, '
                  'tecnologia, equipe, e outros dados relevantes. '
                  'Atualmente, esta informação não está disponível na CryptoEntity.',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorMessageWidget(
          message:
              'Erro ao carregar detalhes da criptomoeda: ${error.toString()}',
          onRetry: () => detailsViewModel.build(cryptoId),
        ),
      ),
    );
  }
}
