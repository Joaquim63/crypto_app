import 'package:crypto_app/data/datasources/crypto_local_datasource.dart.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Core
import 'package:crypto_app/core/network/dio_client.dart';
import 'package:crypto_app/core/constants/api_constants.dart';

// Data Sources
import 'package:crypto_app/data/datasources/crypto_remote_datasource.dart';
import 'package:crypto_app/data/datasources/crypto_remote_datasource_impl.dart';
import 'package:crypto_app/data/datasources/crypto_local_datasource_impl.dart';

// Repositories
import 'package:crypto_app/domain/repositories/crypto_repository.dart';
import 'package:crypto_app/data/repositories/crypto_repository_impl.dart';

// Use Cases
import 'package:crypto_app/domain/usecases/add_favorite_crypto.dart';
import 'package:crypto_app/domain/usecases/get_crypto_details.dart';
import 'package:crypto_app/domain/usecases/get_favorite_cryptos.dart';
import 'package:crypto_app/domain/usecases/remove_favorite_crypto.dart';
import 'package:crypto_app/domain/usecases/search_cryptos.dart';
import 'package:crypto_app/domain/usecases/get_trending_cryptos.dart';
import 'package:crypto_app/domain/usecases/is_crypto_favorite.dart';

// Models (para Hive TypeAdapters)
import 'package:crypto_app/data/models/favorite_crypto_model.dart';

part 'injection_container.g.dart';

// =============================================================================
// CORE / INFRASTRUCTURE
// =============================================================================

/// Provider para a instância do Dio
@Riverpod(
  keepAlive: true,
) // keepAlive para manter a instância viva durante todo o ciclo de vida do app
// ignore: deprecated_member_use_from_same_package
Dio dio(DioRef ref) {
  return Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
}

/// Provider para o DioClient (wrapper do Dio)
@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package
DioClient dioClient(DioClientRef ref) {
  return DioClient(ref.read(dioProvider));
}

/// Provider para a Box do Hive de favoritos
@Riverpod(keepAlive: true)
Future<Box<FavoriteCryptoModel>> favoriteCryptosBox(
  // ignore: deprecated_member_use_from_same_package
  FavoriteCryptosBoxRef ref,
) async {
  // Garante que o TypeAdapter esteja registrado antes de abrir a box
  if (!Hive.isAdapterRegistered(0)) {
    // 0 é o typeId definido em FavoriteCryptoModel
    Hive.registerAdapter(FavoriteCryptoModelAdapter());
  }
  return await Hive.openBox<FavoriteCryptoModel>(
    ApiConstants.favoriteCryptosBoxName,
  );
}

// =============================================================================
// DATA LAYER
// =============================================================================

/// Provider para o CryptoRemoteDataSource
@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package
CryptoRemoteDataSource cryptoRemoteDataSource(CryptoRemoteDataSourceRef ref) {
  return CryptoRemoteDataSourceImpl(ref.read(dioClientProvider));
}

/// Provider para o CryptoLocalDataSource
@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package
Future<CryptoLocalDataSource> cryptoLocalDataSource(
  CryptoLocalDataSourceRef ref,
) async {
  final box = await ref.read(
    favoriteCryptosBoxProvider.future,
  ); // Aguarda a resolução da Future<Box>
  return CryptoLocalDataSourceImpl(
    box,
  ); // Agora a box está pronta para ser passada
}

/// Provider para o CryptoRepository (implementação)
@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package
Future<CryptoRepository> cryptoRepository(CryptoRepositoryRef ref) async {
  final remoteDataSource = ref.read(cryptoRemoteDataSourceProvider);
  final localDataSource = await ref.read(
    cryptoLocalDataSourceProvider.future,
  ); // Aguarda o localDataSource

  return CryptoRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}

// =============================================================================
// DOMAIN LAYER - USE CASES
// =============================================================================

/// Provider para o SearchCryptos Use Case
@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package
Future<SearchCryptos> searchCryptos(SearchCryptosRef ref) async {
  final repository = await ref.read(cryptoRepositoryProvider.future);
  return SearchCryptos(repository);
}

/// Provider para o GetTrendingCryptos Use Case
@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package
Future<GetTrendingCryptos> getTrendingCryptos(GetTrendingCryptosRef ref) async {
  final repository = await ref.read(cryptoRepositoryProvider.future);
  return GetTrendingCryptos(repository);
}

/// Provider para o GetCryptoDetails Use Case
@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package
Future<GetCryptoDetails> getCryptoDetails(GetCryptoDetailsRef ref) async {
  final repository = await ref.read(cryptoRepositoryProvider.future);
  return GetCryptoDetails(repository);
}

/// Provider para o AddFavoriteCrypto Use Case
@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package
Future<AddFavoriteCrypto> addFavoriteCrypto(AddFavoriteCryptoRef ref) async {
  final repository = await ref.read(cryptoRepositoryProvider.future);
  return AddFavoriteCrypto(repository);
}

/// Provider para o RemoveFavoriteCrypto Use Case
@Riverpod(keepAlive: true)
// Tornar o provider assíncrono e aguardar o repositório
// ignore: deprecated_member_use_from_same_package
Future<RemoveFavoriteCrypto> removeFavoriteCrypto(
  RemoveFavoriteCryptoRef ref,
) async {
  final repository = await ref.read(cryptoRepositoryProvider.future);
  return RemoveFavoriteCrypto(repository);
}

/// Provider para o GetFavoriteCryptos Use Case
@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package
Future<GetFavoriteCryptos> getFavoriteCryptos(GetFavoriteCryptosRef ref) async {
  final repository = await ref.read(cryptoRepositoryProvider.future);
  return GetFavoriteCryptos(repository);
}

/// Provider para o IsCryptoFavorite Use Case
@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package
Future<IsCryptoFavorite> isCryptoFavorite(IsCryptoFavoriteRef ref) async {
  final repository = await ref.read(cryptoRepositoryProvider.future);
  return IsCryptoFavorite(repository);
}
