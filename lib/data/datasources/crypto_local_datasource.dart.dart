// lib/data/datasources/crypto_local_datasource.dart
import 'package:crypto_app/data/models/favorite_crypto_model.dart';

abstract class CryptoLocalDataSource {
  Future<void> addFavoriteCrypto(FavoriteCryptoModel crypto);
  Future<void> removeFavoriteCrypto(String id);
  Future<List<FavoriteCryptoModel>> getFavoriteCryptos();
  Future<bool> isCryptoFavorite(String id);
}
