import 'package:dio/dio.dart';
import '../../config/api_config.dart';

class OAuth2Client {
  final Dio _dio = Dio();
  final ApiConfig _config = ApiConfig();

  String? _accessToken;
  DateTime? _expiryTime;

  Future<String> getAccessToken() async {
    if (_accessToken != null &&
        _expiryTime != null &&
        _expiryTime!.isAfter(DateTime.now())) {
      return _accessToken!;
    }
    return await _refreshToken();
  }

  Future<String> _refreshToken() async {
    try {
      final response = await _dio.post(
        '${_config.apiUrl}/oauth/token',
        data: {
          'grant_type': 'client_credentials',
          'client_id': _config.clientId,
          'client_secret': _config.currentSecret,
        },
      );

      _accessToken = response.data['access_token'];
      _expiryTime = DateTime.now().add(
        Duration(seconds: response.data['expires_in'] ?? 7200),
      );

      return _accessToken!;
    } catch (e) {
      throw Exception('Failed to get access token: $e');
    }
  }

  // Méthode pour vérifier si le token est sur le point d'expirer
  bool get isTokenExpiringSoon {
    if (_expiryTime == null) return true;
    final timeUntilExpiry = _expiryTime!.difference(DateTime.now());
    return timeUntilExpiry.inMinutes <
        5; // Consider refreshing if less than 5 minutes left
  }
}
