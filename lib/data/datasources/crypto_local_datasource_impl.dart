// lib/data/datasources/crypto_local_datasource_impl.dart
import 'package:crypto_app/data/datasources/crypto_local_datasource.dart.dart';
import 'package:hive_flutter/hive_flutter.dart'; 
import 'package:crypto_app/data/models/favorite_crypto_model.dart'; 
import 'package:crypto_app/core/errors/exceptions.dart'; 

class CryptoLocalDataSourceImpl implements CryptoLocalDataSource {
  // Declarar favoriteCryptosBox como um campo da classe
  final Box<FavoriteCryptoModel> favoriteCryptosBox;

  // O construtor inicializa o campo declarado acima
  CryptoLocalDataSourceImpl(this.favoriteCryptosBox);

  @override
  Future<void> addFavoriteCrypto(FavoriteCryptoModel crypto) async {
    try {
      // Usar a box injetada diretamente
      await favoriteCryptosBox.put(crypto.id, crypto);
    } catch (e) {
      throw CacheException('Failed to add favorite crypto: $e');
    }
  }

  @override
  Future<void> removeFavoriteCrypto(String id) async {
    try {
      // Usar a box injetada diretamente
      await favoriteCryptosBox.delete(id);
    } catch (e) {
      throw CacheException('Failed to remove favorite crypto: $e');
    }
  }

  @override
  Future<List<FavoriteCryptoModel>> getFavoriteCryptos() async {
    try {
      // Usar a box injetada diretamente
      return favoriteCryptosBox.values.toList();
    } catch (e) {
      throw CacheException('Failed to get favorite cryptos: $e');
    }
  }

  @override
  Future<bool> isCryptoFavorite(String id) async {
    try {
      // Usar a box injetada diretamente
      return favoriteCryptosBox.containsKey(id);
    } catch (e) {
      throw CacheException('Failed to check if crypto is favorite: $e');
    }
  }
}
