import 'package:dio/dio.dart';
import 'package:swifty_companion/config/api_config.dart';
import 'api_interceptor.dart';
import 'oauth2_client.dart';

class ApiClient {
  late final Dio _dio;
  final OAuth2Client _oauth2Client;

  ApiClient(this._oauth2Client) {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig().apiUrl,
    ))..interceptors.add(ApiInterceptor(_oauth2Client));
  }

  Future<Response> get(String path) async {
    return await _dio.get(path);
  }

  // Autres méthodes HTTP selon vos besoins
}