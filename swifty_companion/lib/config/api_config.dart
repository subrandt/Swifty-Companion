import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final ApiConfig _instance = ApiConfig._internal();
  factory ApiConfig() => _instance;
  ApiConfig._internal();

  // Simplement retourner le secret actuel
  String get clientSecret => dotenv.env['API_SECRET'] ?? '';

  String get clientId => dotenv.env['API_UID'] ?? '';

  // Séparer l'URL de base de l'API et l'URL d'authentification
  String get apiUrl => dotenv.env['API_URL'] ?? 'https://api.intra.42.fr/v2';
  String get authUrl =>
      dotenv.env['API_OAUTH_URL'] ?? 'https://api.intra.42.fr/oauth/token';
}
