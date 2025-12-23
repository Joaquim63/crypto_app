// para favoritos
import 'package:crypto_app/data/models/crypto_model.dart';

abstract class CryptoRemoteDataSource {
  Future<List<CryptoModel>> searchCryptos(String query);
  Future<CryptoModel> getCryptoDetails(String id);
  Future<List<CryptoModel>> getTrendingCryptos(); 
}
