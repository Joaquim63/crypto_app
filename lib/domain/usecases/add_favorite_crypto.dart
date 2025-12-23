import 'package:crypto_app/domain/entities/favorite_crypto_entity.dart';
import 'package:crypto_app/domain/repositories/crypto_repository.dart';
import 'package:crypto_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class AddFavoriteCrypto {
  final CryptoRepository repository;

  AddFavoriteCrypto(this.repository);

  Future<Either<Failure, void>> call(FavoriteCryptoEntity crypto) async {
    // Lógica de negócio, como verificar se já é favorito antes de adicionar
    // ou se o objeto é válido.
    if (crypto.id.isEmpty) {
      return const Left(
        InvalidInputFailure('A criptomoeda favorita deve ter um ID válido.'),
      );
    }
    return await _addFavoriteCrypto(crypto);
  }

  Future<Either<Failure, void>> _addFavoriteCrypto(
    FavoriteCryptoEntity crypto,
  ) async {
    try {
      await repository.addFavoriteCrypto(crypto);
      return const Right(
        null,
      ); // Retorna Right(null) para operações sem retorno específico
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
