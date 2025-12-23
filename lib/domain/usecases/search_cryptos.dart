import 'package:crypto_app/domain/entities/crypto_entity.dart';
import 'package:crypto_app/domain/repositories/crypto_repository.dart';
import 'package:crypto_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class SearchCryptos {
  final CryptoRepository repository;

  SearchCryptos(this.repository);

  Future<Either<Failure, List<CryptoEntity>>> call(String query) async {
    if (query.isEmpty) {
      return const Left(
        InvalidInputFailure('A query de busca não pode ser vazia.'),
      );
    }
    return await _searchCryptos(query);
  }

  Future<Either<Failure, List<CryptoEntity>>> _searchCryptos(
    String query,
  ) async {
    try {
      final result = await repository.searchCryptos(query);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message);
}
