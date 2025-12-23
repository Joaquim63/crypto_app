import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crypto_app/domain/entities/favorite_crypto_entity.dart';
import 'package:crypto_app/domain/usecases/get_favorite_cryptos.dart';
import 'package:crypto_app/domain/usecases/remove_favorite_crypto.dart';
import 'package:crypto_app/di/injection_container.dart'; 

part 'favorites_viewmodel.g.dart';

@riverpod
class FavoritesViewModel extends _$FavoritesViewModel {
  // Use Cases injetados (serão inicializados no build)
  late GetFavoriteCryptos _getFavoriteCryptos;
  late RemoveFavoriteCrypto _removeFavoriteCrypto;

  // O método `build` é o construtor do estado inicial do NotifierProvider.
  // Ele pode ser assíncrono e seu tipo de retorno define o tipo de estado do Notifier.
  @override
  Future<List<FavoriteCryptoEntity>> build() async {
    _getFavoriteCryptos = await ref.read(getFavoriteCryptosProvider.future);
    _removeFavoriteCrypto = await ref.read(removeFavoriteCryptoProvider.future);

    // Carrega a lista inicial de favoritos
    return _fetchFavoriteCryptos();
  }

  Future<List<FavoriteCryptoEntity>> _fetchFavoriteCryptos() async {
    final result = await _getFavoriteCryptos();
    return result.fold(
      (failure) =>
          throw failure, // Lança a falha para ser capturada pelo AsyncError
      (cryptos) => cryptos,
    );
  }

  Future<void> removeFavorite(String id) async {
    // Define o estado como carregando para indicar que uma operação está em andamento
    state = const AsyncValue.loading();

    final result = await _removeFavoriteCrypto(id);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) async {
        // Usamos AsyncValue.guard para capturar quaisquer erros durante o _fetchFavoriteCryptos
        state = await AsyncValue.guard(() => _fetchFavoriteCryptos());
      },
    );
  }
}
