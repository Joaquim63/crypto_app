import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_app/presentation/viewmodels/favorites_viewmodel.dart';
import 'package:crypto_app/presentation/widgets/crypto_list_tile.dart';
import 'package:crypto_app/presentation/widgets/error_message_widget.dart';
import 'package:crypto_app/domain/entities/crypto_entity.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesViewModelState = ref.watch(favoritesViewModelProvider);
    final favoritesViewModel = ref.read(favoritesViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Criptomoedas Favoritas')),
      body: favoritesViewModelState.when(
        data: (favoriteCryptos) {
          if (favoriteCryptos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Você ainda não adicionou nenhuma criptomoeda aos favoritos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: favoriteCryptos.length,
            itemBuilder: (context, index) {
              final favoriteCrypto = favoriteCryptos[index];
              // Converte FavoriteCryptoEntity para CryptoEntity para usar no CryptoListTile
              final crypto = CryptoEntity(
                id: favoriteCrypto.id,
                symbol: favoriteCrypto.symbol,
                name: favoriteCrypto.name,
                image: favoriteCrypto.image,
                currentPrice: favoriteCrypto.currentPrice,
                marketCap: favoriteCrypto.marketCap,
                priceChangePercentage24h:
                    favoriteCrypto.priceChangePercentage24h,
                // Campos adicionais da CryptoEntity que não estão na FavoriteCryptoEntity
                marketCapRank: 0, // Valor padrão
                high24h: 0.0, // Valor padrão
                low24h: 0.0, // Valor padrão
                priceChange24h: 0.0, // Valor padrão
                marketCapChange24h: 0.0, // Valor padrão
                marketCapChangePercentage24h: 0.0, // Valor padrão
                circulatingSupply: 0.0, // Valor padrão
                totalSupply: 0.0, // Valor padrão
                maxSupply: 0.0, // Valor padrão
                ath: 0.0, // Valor padrão
                athChangePercentage: 0.0, // Valor padrão
                athDate: '', // Valor padrão
                atl: 0.0, // Valor padrão
                atlChangePercentage: 0.0, // Valor padrão
                atlDate: '', // Valor padrão
                roi: null, // Pode ser null se o tipo permitir
                lastUpdated: '', // Valor padrão
                priceChangePercentage7dInCurrency: 0.0, // Valor padrão
              );
              return CryptoListTile(
                crypto: crypto,
                onRemoveFavorite: () {
                  _confirmRemoveFavorite(
                    context,
                    favoritesViewModel,
                    favoriteCrypto.id,
                    favoriteCrypto.name,
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorMessageWidget(
          message: 'Erro ao carregar favoritos: ${error.toString()}',
          onRetry: () => favoritesViewModel.build(), // Tenta recarregar a lista
        ),
      ),
    );
  }

  // Função para exibir o diálogo de confirmação
  Future<void> _confirmRemoveFavorite(
    BuildContext context,
    FavoritesViewModel viewModel,
    String id,
    String name,
  ) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remover Favorito'),
          content: Text(
            'Tem certeza que deseja remover "$name" dos seus favoritos?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Remover', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await viewModel.removeFavorite(id);
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('$name removido dos favoritos.')));
    }
  }
}
