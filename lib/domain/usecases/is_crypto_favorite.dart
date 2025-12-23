import 'package:crypto_app/domain/repositories/crypto_repository.dart';
import 'package:crypto_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class IsCryptoFavorite {
  final CryptoRepository repository;

  IsCryptoFavorite(this.repository);

  Future<Either<Failure, bool>> call(String id) async {
    if (id.isEmpty) {
      return const Left(
        InvalidInputFailure('O ID da criptomoeda não pode ser vazio.'),
      );
    }
    try {
      final result = await repository.isCryptoFavorite(id);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
