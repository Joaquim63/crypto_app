import 'package:dio/dio.dart';
import 'package:crypto_app/core/network/dio_client.dart';
import 'package:crypto_app/data/datasources/crypto_remote_datasource.dart';
import 'package:crypto_app/data/models/crypto_model.dart';
import 'package:crypto_app/core/errors/exceptions.dart';
import 'package:crypto_app/core/constants/api_constants.dart';
import 'dart:developer';

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  final DioClient dioClient;

  CryptoRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<CryptoModel>> searchCryptos(String query) async {
    log('DEBUG: searchCryptos - Iniciando busca para query: $query');
    try {
      final searchResponse = await dioClient.get(
        '${ApiConstants.searchEndpoint}?query=$query',
      );

      log('DEBUG: searchCryptos - Status Code: ${searchResponse.statusCode}');
      log('DEBUG: searchCryptos - Response Data: ${searchResponse.data}');

      if (searchResponse.statusCode == 200 && searchResponse.data != null) {
        final List<dynamic>? results = searchResponse.data['coins'];

        if (results == null) {
          log(
            'WARNING: searchCryptos - "coins" field is null in search response. Returning empty list.',
          );
          return [];
        }

        final List<CryptoModel> cryptos = [];
        for (var item in results) {
          try {
            if (item is Map<String, dynamic> &&
                item['item'] is Map<String, dynamic>) {
              final Map<String, dynamic> coinData = item['item'];
              // Mapeia a estrutura da API de search para o formato esperado pelo CryptoModel.fromJson
              final mappedData = {
                'id': coinData['id'] as String?,
                'symbol': coinData['symbol'] as String?,
                'name': coinData['name'] as String?,
                'image': {
                  'thumb': coinData['thumb'],
                  'small': coinData['small'],
                  'large': coinData['large'],
                },
                'market_data': {
                  'current_price': {
                    'usd': (coinData['data']['price'] as num?)?.toDouble(),
                  },
                  'market_cap': {
                    'usd': _parseMarketCapString(
                      coinData['data']['market_cap'] as String?,
                    ),
                  },
                  'market_cap_rank': (coinData['market_cap_rank'] as num?)
                      ?.toInt(),
                  'price_change_percentage_24h_in_currency': {
                    'usd':
                        (coinData['data']['price_change_percentage_24h']['usd']
                                as num?)
                            ?.toDouble(),
                  },
                  // Campos que não vêm na API de search/trending, definidos como null
                  'high_24h': null,
                  'low_24h': null,
                  'price_change_24h': null,
                  'market_cap_change_24h': null,
                  'market_cap_change_percentage_24h': null,
                  'circulating_supply': null,
                  'total_supply': null,
                  'max_supply': null,
                  'ath': null,
                  'ath_change_percentage': null,
                  'ath_date': null,
                  'atl': null,
                  'atl_change_percentage': null,
                  'atl_date': null,
                  'roi': null,
                  'price_change_percentage_7d_in_currency': null,
                },
                'last_updated': DateTime.now()
                    .toIso8601String(), // Usar data atual como fallback
              };
              cryptos.add(CryptoModel.fromJson(mappedData));
            } else {
              log(
                'WARNING: searchCryptos - Item inesperado na lista de busca: $item. Ignorando.',
              );
            }
          } catch (e, stack) {
            log(
              'ERROR: searchCryptos - Erro ao criar CryptoModel a partir do item $item: $e\n$stack',
            );
          }
        }
        log('DEBUG: searchCryptos - Retornando ${cryptos.length} resultados.');
        return cryptos;
      } else {
        log(
          'ERROR: searchCryptos - Falha na requisição de busca: ${searchResponse.statusCode}',
        );
        throw ServerException(
          'Failed to search cryptos: ${searchResponse.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log(
          'ERROR: searchCryptos - DioException com resposta: ${e.response?.statusCode} - ${e.response?.data}',
        );
        throw ServerException(
          'API Error: ${e.response?.statusCode} - ${e.response?.data}',
        );
      } else {
        log('ERROR: searchCryptos - DioException sem resposta: ${e.message}');
        throw NetworkException('Network Error: ${e.message}');
      }
    } catch (e, stack) {
      log('FATAL ERROR: searchCryptos - Erro inesperado: $e\n$stack');
      throw UnknownException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<CryptoModel>> getTrendingCryptos() async {
    log('DEBUG: getTrendingCryptos - Iniciando busca por trending cryptos');
    try {
      final response = await dioClient.get(ApiConstants.trendingEndpoint);

      log('DEBUG: getTrendingCryptos - Status Code: ${response.statusCode}');
      log('DEBUG: getTrendingCryptos - Response Data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic>? results = response.data['coins'];

        if (results == null) {
          log(
            'WARNING: getTrendingCryptos - "coins" field is null in trending response. Returning empty list.',
          );
          return [];
        }

        final List<CryptoModel> cryptos = [];
        for (var item in results) {
          try {
            if (item is Map<String, dynamic> &&
                item['item'] is Map<String, dynamic>) {
              final Map<String, dynamic> coinData = item['item'];
              // Mapeia a estrutura da API de trending para o formato esperado pelo CryptoModel.fromJson
              final mappedData = {
                'id': coinData['id'] as String?,
                'symbol': coinData['symbol'] as String?,
                'name': coinData['name'] as String?,
                'image': {
                  'thumb': coinData['thumb'],
                  'small': coinData['small'],
                  'large': coinData['large'],
                },
                'market_data': {
                  'current_price': {
                    'usd': (coinData['data']['price'] as num?)?.toDouble(),
                  },
                  'market_cap': {
                    'usd': _parseMarketCapString(
                      coinData['data']['market_cap'] as String?,
                    ),
                  },
                  'market_cap_rank': (coinData['market_cap_rank'] as num?)
                      ?.toInt(),
                  'price_change_percentage_24h_in_currency': {
                    'usd':
                        (coinData['data']['price_change_percentage_24h']['usd']
                                as num?)
                            ?.toDouble(),
                  },
                  // Campos que não vêm na API de search/trending, definidos como null
                  'high_24h': null,
                  'low_24h': null,
                  'price_change_24h': null,
                  'market_cap_change_24h': null,
                  'market_cap_change_percentage_24h': null,
                  'circulating_supply': null,
                  'total_supply': null,
                  'max_supply': null,
                  'ath': null,
                  'ath_change_percentage': null,
                  'ath_date': null,
                  'atl': null,
                  'atl_change_percentage': null,
                  'atl_date': null,
                  'roi': null,
                  'price_change_percentage_7d_in_currency': null,
                },
                'last_updated': DateTime.now()
                    .toIso8601String(), // Usar data atual como fallback
              };
              cryptos.add(CryptoModel.fromJson(mappedData));
            } else {
              log(
                'WARNING: getTrendingCryptos - Item inesperado na lista de trending: $item. Ignorando.',
              );
            }
          } catch (e, stack) {
            log(
              'ERROR: getTrendingCryptos - Erro ao criar CryptoModel a partir do item $item: $e\n$stack',
            );
          }
        }
        log(
          'DEBUG: getTrendingCryptos - Retornando ${cryptos.length} resultados.',
        );
        return cryptos;
      } else {
        log(
          'ERROR: getTrendingCryptos - Falha na requisição de trending: ${response.statusCode}',
        );
        throw ServerException(
          'Failed to get trending cryptos: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log(
          'ERROR: getTrendingCryptos - DioException com resposta: ${e.response?.statusCode} - ${e.response?.data}',
        );
        throw ServerException(
          'API Error: ${e.response?.statusCode} - ${e.response?.data}',
        );
      } else {
        log(
          'ERROR: getTrendingCryptos - DioException sem resposta: ${e.message}',
        );
        throw NetworkException('Network Error: ${e.message}');
      }
    } catch (e, stack) {
      log('FATAL ERROR: getTrendingCryptos - Erro inesperado: $e\n$stack');
      throw UnknownException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<CryptoModel> getCryptoDetails(String id) async {
    log('DEBUG: getCryptoDetails - Iniciando busca por detalhes para ID: $id');
    try {
      final response = await dioClient.get(
        ApiConstants.getCoinDetailsEndpoint(id),
      );

      log('DEBUG: getCryptoDetails - Status Code: ${response.statusCode}');
      log(
        'DEBUG: getCryptoDetails - Response Data (parcial): ${response.data.toString().substring(0, response.data.toString().length > 500 ? 500 : response.data.toString().length)}...',
      ); // Log parcial para não poluir

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> data = response.data;
        log(
          'DEBUG: getCryptoDetails - Dados recebidos para ID: $id. Convertendo para CryptoModel.',
        );
        return CryptoModel.fromJson(data);
      } else {
        log(
          'ERROR: getCryptoDetails - Falha na requisição de detalhes: ${response.statusCode}',
        );
        throw ServerException(
          'Failed to get crypto details: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log(
          'ERROR: getCryptoDetails - DioException com resposta: ${e.response?.statusCode} - ${e.response?.data}',
        );
        throw ServerException(
          'API Error: ${e.response?.statusCode} - ${e.response?.data}',
        );
      } else {
        log(
          'ERROR: getCryptoDetails - DioException sem resposta: ${e.message}',
        );
        throw NetworkException('Network Error: ${e.message}');
      }
    } catch (e, stack) {
      log('FATAL ERROR: getCryptoDetails - Erro inesperado: $e\n$stack');
      throw UnknownException('An unexpected error occurred: $e');
    }
  }

  // Função auxiliar para parsear o market_cap que vem como String na API de trending/search
  double? _parseMarketCapString(String? marketCapString) {
    if (marketCapString == null || marketCapString.isEmpty) return null;
    final cleanedString = marketCapString.replaceAll(RegExp(r'[$,]'), '');
    return double.tryParse(cleanedString);
  }
}
