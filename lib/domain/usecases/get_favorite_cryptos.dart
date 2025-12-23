import 'package:crypto_app/domain/entities/favorite_crypto_entity.dart';
import 'package:crypto_app/domain/repositories/crypto_repository.dart';
import 'package:crypto_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class GetFavoriteCryptos {
  final CryptoRepository repository;

  GetFavoriteCryptos(this.repository);

  Future<Either<Failure, List<FavoriteCryptoEntity>>> call() async {
    return await _getFavoriteCryptos();
  }

  Future<Either<Failure, List<FavoriteCryptoEntity>>>
  _getFavoriteCryptos() async {
    try {
      final result = await repository.getFavoriteCryptos();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
