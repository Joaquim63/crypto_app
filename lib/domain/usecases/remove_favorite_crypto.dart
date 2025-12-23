import 'package:crypto_app/domain/repositories/crypto_repository.dart';
import 'package:crypto_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class RemoveFavoriteCrypto {
  final CryptoRepository repository;

  RemoveFavoriteCrypto(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    if (id.isEmpty) {
      return const Left(
        InvalidInputFailure('O ID da criptomoeda não pode ser vazio.'),
      );
    }
    return await _removeFavoriteCrypto(id);
  }

  Future<Either<Failure, void>> _removeFavoriteCrypto(String id) async {
    try {
      await repository.removeFavoriteCrypto(id);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
