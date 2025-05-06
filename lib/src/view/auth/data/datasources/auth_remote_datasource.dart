import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prime_pronta_resposta/src/core/endpoints/app_endpoints.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/entities/login_entities.dart';
import 'package:prime_pronta_resposta/src/view/auth/model/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginEntity> login(String email, String password);
  Future<bool> hasToken();
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage storage;

  AuthRemoteDataSourceImpl(this.dio, this.storage);

  @override
  Future<LoginEntity> login(String email, String password) async {
    try {
      final response = await dio.post(
        AppEndpoints.login,
        data: {'email': email, 'password': password},
      );

      final data = response.data;

      final loginModel = LoginModel.fromJson(data);

      if (loginModel.code == 1) {
        await storage.write(key: 'auth_token', value: loginModel.token);
      }

      return loginModel;
    } catch (e) {
      throw Exception('Erro ao fazer login: $e');
    }
  }

  @override
  Future<bool> hasToken() async {
    final token = await storage.read(key: 'auth_token');
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> logout() {
    return storage.delete(key: 'auth_token');
  }
}
