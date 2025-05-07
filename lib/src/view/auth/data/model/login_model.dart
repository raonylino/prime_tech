import 'package:prime_pronta_resposta/src/view/auth/domain/entities/login_entities.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.code,
    required super.message,
    required super.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      token: json['data'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'data': token};
  }
}
