import 'package:dio/dio.dart';
import 'package:crypto_app/core/errors/exceptions.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Erro desconhecido na requisição GET');
    } catch (e) {
      throw ServerException('Erro inesperado: ${e.toString()}');
    }
  }

}
