import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prime_pronta_resposta/src/feature/auth/domain/entities/s3_entity.dart';

class AppEndpoints {
  /* ---------------------------------- BASE ---------------------------------- */
  static final String _baseUrl = dotenv.env['BASE_URL']!;
  static final String _apiUrl = Uri.parse(_baseUrl).host;

  /* ---------------------------------- Login ---------------------------------- */
  static String apiBase = 'https://$_apiUrl/api/v1';
  static String login = '/login';
  static String dataOperation = '$apiBase/service/evidence';

  /* ---------------------------------- Photo S3 ---------------------------------- */
  static String photoUrl({required S3Entity s3}) {
    return 'https://${s3.bucket}.s3.${s3.region}.amazonaws.com/${s3.directory}';
  }
}
