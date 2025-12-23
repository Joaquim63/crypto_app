import 'package:crypto_app/domain/entities/crypto_entity.dart';
import 'package:crypto_app/domain/entities/favorite_crypto_entity.dart';

abstract class CryptoRepository {
  // Métodos para buscar e obter detalhes de criptomoedas
  Future<List<CryptoEntity>> searchCryptos(String query);
  Future<CryptoEntity> getCryptoDetails(String id);
  Future<List<CryptoEntity>>
  getTrendingCryptos(); 
  
  // Métodos para gerenciar criptomoedas favoritas
  Future<void> addFavoriteCrypto(FavoriteCryptoEntity crypto);
  Future<void> removeFavoriteCrypto(String id);
  Future<List<FavoriteCryptoEntity>> getFavoriteCryptos();
  Future<bool> isCryptoFavorite(String id);
}
