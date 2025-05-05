import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEndpoints {
  /* ---------------------------------- BASE ---------------------------------- */
  static final String _baseUrl = dotenv.env['BASE_URL']!;
  static final String _apiUrl = Uri.parse(_baseUrl).host;

  /* ---------------------------------- Login ---------------------------------- */
  static String apiBase = 'https://$_apiUrl/api/v1';
  static String login = '/login';
}
