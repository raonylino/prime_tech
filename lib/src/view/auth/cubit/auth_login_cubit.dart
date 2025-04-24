import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'auth_login_state.dart';

class AuthLoginCubit extends Cubit<AuthLoginState> {
  AuthLoginCubit() : super(AuthLoginInitial());

  final _storage = FlutterSecureStorage();
 final String baseUrl = dotenv.env['BASE_URL']!;

  void login({required String email, required String password}) async {
    emit(AuthLoginLoading());

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: {'email': email, 'password': password},
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['code'] == 1) {
        final token = responseData['data'];
        await _storage.write(key: 'auth_token', value: token);
        emit(AuthLoginSuccess());
      } else {
        emit(
          AuthLoginFailure(responseData['message'] ?? 'Erro ao fazer login.'),
        );
      }
    } catch (e) {
      emit(AuthLoginFailure('Erro de conexão: ${e.toString()}'));
    }
  }

  void checkLoginStatus() async {
    emit(AuthLoginLoading());
    final token = await _storage.read(key: 'auth_token');

    if (token != null && token.isNotEmpty) {
      emit(AuthLoginSuccess());
    } else {
      emit(AuthLoginInitial());
    }
  }

  void logout() async {
    await _storage.delete(key: 'auth_token');
    emit(AuthLoginInitial());
  }
}
