import 'package:dio/dio.dart';
import 'package:swifty_companion/core/network/oauth2_client.dart';

class ApiInterceptor extends Interceptor {
  final OAuth2Client _oauth2Client;

  ApiInterceptor(this._oauth2Client);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Ajouter le token à chaque requête
    final token = await _oauth2Client.getAccessToken();
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token invalide ou expiré, on peut essayer de rafraîchir
      await _oauth2Client.getAccessToken();
      // Retenter la requête
      final opts = err.requestOptions;
      final token = await _oauth2Client.getAccessToken();
      opts.headers['Authorization'] = 'Bearer $token';
      try {
        final response = await Dio().fetch(opts);
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(err);
      }
    }
    return handler.reject(err);
  }
}