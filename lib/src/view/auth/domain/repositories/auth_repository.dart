import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:prime_pronta_resposta/src/view/auth/data/datasources/auth_remote_datasource.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/entities/login_entities.dart';

abstract class AuthRepository {
  Future<Either<Exception, LoginEntity>> login(String email, String password);

  Future<bool> checkLoginStatus();
  Future<void> logout();
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final FlutterSecureStorage storage;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.dio, this.storage, this.authRemoteDataSource);

  @override
  Future<Either<Exception, LoginEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await authRemoteDataSource.login(email, password);
      if (result.code == 1) {
        return Right(result);
      } else {
        return Left(Exception(result.message.toString()));
      }
    } catch (e) {
      return Left(Exception('Erro ao fazer login: $e'));
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
