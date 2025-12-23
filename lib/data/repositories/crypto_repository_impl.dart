// Este é o arquivo que implementa o CryptoRepository e atua como a ponte entre os DataSources (remoto e local) e os Use Cases.
import 'package:crypto_app/data/datasources/crypto_local_datasource.dart.dart';
import 'package:crypto_app/data/datasources/crypto_remote_datasource.dart';
import 'package:crypto_app/data/models/favorite_crypto_model.dart';
import 'package:crypto_app/domain/entities/crypto_entity.dart';
import 'package:crypto_app/domain/entities/favorite_crypto_entity.dart';
import 'package:crypto_app/domain/repositories/crypto_repository.dart';
import 'package:crypto_app/core/errors/exceptions.dart';
import 'package:crypto_app/core/errors/failures.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoRemoteDataSource remoteDataSource;
  final CryptoLocalDataSource localDataSource;

  CryptoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<CryptoEntity>> searchCryptos(String query) async {
    try {
      final remoteCryptos = await remoteDataSource.searchCryptos(query);
      return remoteCryptos;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  @override
  Future<CryptoEntity> getCryptoDetails(String id) async {
    try {
      final remoteCrypto = await remoteDataSource.getCryptoDetails(id);
      return remoteCrypto;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  @override
  Future<List<CryptoEntity>> getTrendingCryptos() async {
    try {
      final remoteCryptos = await remoteDataSource.getTrendingCryptos();
      return remoteCryptos;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  @override
  Future<void> addFavoriteCrypto(FavoriteCryptoEntity crypto) async {
    try {
      final favoriteModel = FavoriteCryptoModel.fromEntity(crypto);
      await localDataSource.addFavoriteCrypto(favoriteModel);
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  @override
  Future<void> removeFavoriteCrypto(String id) async {
    try {
      await localDataSource.removeFavoriteCrypto(id);
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  @override
  Future<List<FavoriteCryptoEntity>> getFavoriteCryptos() async {
    try {
      final localCryptos = await localDataSource.getFavoriteCryptos();
      return localCryptos;
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  @override
  Future<bool> isCryptoFavorite(String id) async {
    try {
      return await localDataSource.isCryptoFavorite(id);
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}
