import 'package:prime_pronta_resposta/src/feature/auth/data/model/login_model.dart';
import 'package:prime_pronta_resposta/src/feature/auth/data/model/s3_model.dart';

class LoginResult {
  final LoginModel login;
  final S3Model s3;

  LoginResult({required this.login, required this.s3});
}
