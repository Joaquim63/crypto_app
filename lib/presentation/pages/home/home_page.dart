import 'package:crypto_app/presentation/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:crypto_app/presentation/widgets/crypto_list_tile.dart';
import 'package:crypto_app/presentation/widgets/error_message_widget.dart';
import 'package:crypto_app/presentation/pages/favorites/favorites_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModelState = ref.watch(homeViewModelProvider);
    final homeViewModel = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomSearchBar(
              onSearch: (query) {
                homeViewModel.searchCryptos(query);
              },
              hintText: 'Buscar criptomoedas...',
            ),
          ),
          Expanded(
            child: homeViewModelState.when(
              data: (cryptos) {
                if (cryptos.isEmpty) {
                  return const Center(
                    child: Text('Nenhuma criptomoeda encontrada.'),
                  );
                }
                return ListView.builder(
                  itemCount: cryptos.length,
                  itemBuilder: (context, index) {
                    final crypto = cryptos[index];
                    return CryptoListTile(
                      crypto: crypto,
                      // A lógica de adicionar/remover favorito será tratada dentro do CryptoListTile
                      // que usará o DetailsViewModel para isso.
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => ErrorMessageWidget(
                message: 'Erro ao carregar criptomoedas: ${error.toString()}',
                onRetry: () =>
                    homeViewModel.searchCryptos(homeViewModel.searchQuery),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
