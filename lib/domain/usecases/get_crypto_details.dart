// lib/domain/usecases/get_crypto_details.dart
import 'package:crypto_app/domain/entities/crypto_entity.dart';
import 'package:crypto_app/domain/repositories/crypto_repository.dart';
import 'package:crypto_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class GetCryptoDetails {
  final CryptoRepository repository;

  GetCryptoDetails(this.repository);

  Future<Either<Failure, CryptoEntity>> call(String id) async {
    // Lógica de negócio, como validação do ID
    if (id.isEmpty) {
      return const Left(
        InvalidInputFailure('O ID da criptomoeda não pode ser vazio.'),
      );
    }
    return await _getCryptoDetails(id);
  }

  Future<Either<Failure, CryptoEntity>> _getCryptoDetails(String id) async {
    try {
      final result = await repository.getCryptoDetails(id);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
