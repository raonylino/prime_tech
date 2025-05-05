import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:prime_pronta_resposta/src/core/endpoints/app_endpoints.dart';
import '../../domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final FlutterSecureStorage storage;

  AuthRepositoryImpl(this.dio, this.storage);

  @override
  Future<void> login(String email, String password) async {
    final response = await dio.post(
      AppEndpoints.login,
      data: {'email': email, 'password': password},
    );
 
    final data = response.data;

    if (response.statusCode == 200 && data['code'] == 1) {
      await storage.write(key: 'auth_token', value: data['data']);
    } else {
      throw Exception(data['message'] ?? 'Erro ao fazer login');
    }
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: 'auth_token');
  }

  @override
  Future<bool> checkLoginStatus() async {
    final token = await storage.read(key: 'auth_token');
    return token != null && token.isNotEmpty;
  }
}
