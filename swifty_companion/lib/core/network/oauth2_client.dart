import 'package:dio/dio.dart';
import 'package:swifty_companion/core/errors/exceptions.dart';
import '../../config/api_config.dart';

class OAuth2Client {
  final Dio _dio = Dio();
  final ApiConfig _config = ApiConfig();

  String? _accessToken;
  DateTime? _expiryTime;

  // Get the access token only if it's not expired
  Future<String> getAccessToken() async {
    if (_accessToken != null &&
        _expiryTime != null &&
        _expiryTime!.isAfter(DateTime.now())) {
      return _accessToken!; // Return the current token
    }
    return await _refreshToken(); // Refresh the token
  }

  // Refresh the access token
  Future<String> _refreshToken() async {
    try {
      final requestData = {
        'grant_type': 'client_credentials',
        'client_id': _config.clientId,
        'client_secret': _config.clientSecret,
      };

      final response = await _dio.post(
        _config.authUrl,
        data: requestData,
      );

      _accessToken = response.data['access_token'];
      print('🔑 New access token obtained successfully: $_accessToken');
      _expiryTime = DateTime.now().add(
        Duration(seconds: response.data['expires_in'] ?? 7200),
      );

      return _accessToken!;
    } catch (e) {
      throw ApiError('Failed to get access token: $e');
    }
  }

  // Verify if token is expiring soon
  bool get isTokenExpiringSoon {
    if (_expiryTime == null) return true;
    final timeUntilExpiry = _expiryTime!.difference(DateTime.now());
    return timeUntilExpiry.inMinutes <
        5; // Consider refreshing if less than 5 minutes left
  }
}
