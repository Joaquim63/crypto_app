import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crypto_app/domain/entities/crypto_entity.dart';
import 'package:crypto_app/domain/usecases/get_trending_cryptos.dart';
import 'package:crypto_app/domain/usecases/search_cryptos.dart';
import 'package:crypto_app/di/injection_container.dart';
import 'dart:developer'; 
part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late SearchCryptos _searchCryptos;
  late GetTrendingCryptos _getTrendingCryptos;

  @override
  Future<List<CryptoEntity>> build() async {
    _searchCryptos = await ref.read(searchCryptosProvider.future);
    _getTrendingCryptos = await ref.read(getTrendingCryptosProvider.future);

    log(
      'DEBUG: HomeViewModel - Carregando criptomoedas em alta na inicialização.',
    );
    return _fetchTrendingCryptos();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Future<void> searchCryptos(String query) async {
    _searchQuery = query;
    state = const AsyncValue.loading();
    log('DEBUG: HomeViewModel - Iniciando busca por: $query');

    if (query.isEmpty) {
      log('DEBUG: HomeViewModel - Query vazia, carregando trending cryptos.');
      state = await AsyncValue.guard(() => _fetchTrendingCryptos());
      return;
    }

    final result = await _searchCryptos(query);
    result.fold(
      (failure) {
        log('ERROR: HomeViewModel - Falha na busca: $failure');
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (cryptos) {
        log(
          'DEBUG: HomeViewModel - Busca bem-sucedida, ${cryptos.length} resultados.',
        );
        state = AsyncValue.data(cryptos);
      },
    );
  }

  Future<List<CryptoEntity>> _fetchTrendingCryptos() async {
    log('DEBUG: HomeViewModel - Buscando criptomoedas em alta.');
    final result = await _getTrendingCryptos();
    return result.fold(
      (failure) {
        log(
          'ERROR: HomeViewModel - Falha ao buscar trending cryptos: $failure',
        );
        throw failure;
      },
      (cryptos) {
        log(
          'DEBUG: HomeViewModel - Trending cryptos carregadas, ${cryptos.length} resultados.',
        );
        return cryptos;
      },
    );
  }
}
