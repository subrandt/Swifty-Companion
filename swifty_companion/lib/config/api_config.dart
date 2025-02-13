import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final ApiConfig _instance = ApiConfig._internal();
  factory ApiConfig() => _instance;
  ApiConfig._internal();

  String get currentSecret {
    final switchDate = DateTime(2025, 2, 25);
    if (DateTime.now().isAfter(switchDate)) {
      return dotenv.env['API_SECRET_NEXT'] ?? '';
    }
    return dotenv.env['API_SECRET'] ?? '';
  }

  String get clientId => dotenv.env['API_UID'] ?? '';
  String get apiUrl => dotenv.env['API_URL'] ?? 'https://api.intra.42.fr';
}
