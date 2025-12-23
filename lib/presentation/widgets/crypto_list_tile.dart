// lib/presentation/widgets/crypto_list_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importar ConsumerWidget
import 'package:crypto_app/domain/entities/crypto_entity.dart';
import 'package:crypto_app/presentation/viewmodels/details_viewmodel.dart'; // Para interagir com o favorito
import 'package:crypto_app/presentation/pages/details/details_page.dart'; // Para navegação

class CryptoListTile extends ConsumerWidget {
  final CryptoEntity crypto;
  final VoidCallback? onRemoveFavorite; // Opcional, para a tela de favoritos

  const CryptoListTile({
    super.key,
    required this.crypto,
    this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa o estado completo do DetailsViewModel para esta criptomoeda específica
    final detailsViewModelState = ref.watch(
      detailsViewModelProvider(crypto.id),
    );

    // Extrai o estado de favorito de forma segura
    // CORREÇÃO AQUI: Acessar isFavorite do DetailsPageState dentro do AsyncValue
    final isFavoriteAsyncValue = detailsViewModelState.when(
      data: (pageState) => pageState.isFavorite, // Retorna AsyncValue<bool>
      loading: () => const AsyncValue.loading(), // Enquanto o ViewModel carrega
      error: (err, stack) =>
          AsyncValue.error(err, stack), // Se houver erro no ViewModel
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          // ignore: deprecated_member_use
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Text(
            crypto.symbol.toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          crypto.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Preço: \$${crypto.currentPrice.toStringAsFixed(2)} | Variação 24h: ${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
          style: TextStyle(
            color: crypto.priceChangePercentage24h >= 0
                ? Colors.green
                : Colors.red,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botão de Favorito
            if (onRemoveFavorite ==
                null) // Só mostra o botão de adicionar/remover se não for a tela de favoritos
              isFavoriteAsyncValue.when(
                // CORREÇÃO AQUI: Usar isFavoriteAsyncValue
                data: (isFav) => IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    // Toggle favorito
                    // CORREÇÃO AQUI: Remover o argumento 'crypto'
                    ref
                        .read(detailsViewModelProvider(crypto.id).notifier)
                        .toggleFavorite();
                  },
                ),
                loading: () => const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (err, stack) => IconButton(
                  icon: const Icon(Icons.error, color: Colors.orange),
                  onPressed: () {
                    // Opcional: mostrar um SnackBar com o erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro ao verificar favorito: $err'),
                      ),
                    );
                  },
                ),
              ),
            // Botão de Remover Favorito (apenas para a tela de favoritos)
            if (onRemoveFavorite != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onRemoveFavorite,
              ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailsPage(cryptoId: crypto.id),
            ),
          );
        },
      ),
    );
  }
}
