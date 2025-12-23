import 'package:crypto_app/domain/entities/crypto_entity.dart';
import 'package:crypto_app/domain/repositories/crypto_repository.dart';
import 'package:crypto_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class GetTrendingCryptos {
  final CryptoRepository repository;

  GetTrendingCryptos(this.repository);

  Future<Either<Failure, List<CryptoEntity>>> call() async {
    return await _getTrendingCryptos();
  }

  Future<Either<Failure, List<CryptoEntity>>> _getTrendingCryptos() async {
    try {
      final result = await repository.getTrendingCryptos();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
