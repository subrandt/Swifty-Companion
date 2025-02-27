import 'package:dio/dio.dart';
import 'package:swifty_companion/config/api_config.dart';
import 'package:swifty_companion/core/errors/exceptions.dart';
import 'api_interceptor.dart';
import 'oauth2_client.dart';

class ApiClient {
  late final Dio _dio;
  final OAuth2Client _oauth2Client;

  ApiClient(this._oauth2Client) {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig().apiUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ))
      ..interceptors.add(ApiInterceptor(_oauth2Client));
  }

  Future<Map<String, dynamic>> searchUser(String login) async {
    try {
      final response = await _dio.get('/users/$login');
      return response.data;
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 404) {
          throw UserException('User not found');
        }
        throw ApiError('${e.message}');
      }
      throw UserException('Failed to search user: $e');
    }
  }

  Future<Response> get(String path) async {
    return await _dio.get(path);
  }
}
