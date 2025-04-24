import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prime_pronta_resposta/src/constants/app_routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<void> loadUserProfile() async {
    emit(ProfileLoading());

    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) {
        emit(ProfileError('Token não encontrado'));
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['code'] == 1) {
          final userData = data['data'];
          final name = userData['name'];
          final email = userData['email'];
          final imageUrl = userData['image_profile_path'];
          final phone = userData['phone'] ?? '';

          emit(ProfileLoaded(name: name, email: email, imageUrl: imageUrl, phone: phone));
        } else {
          emit(ProfileError(data['message']));
        }
      } else {
        emit(ProfileError('Erro: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProfileError('Erro de conexão: ${e.toString()}'));
    }
  }

  void logout(BuildContext context) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    navigator.pushNamedAndRemoveUntil(AppRouters.loginPage, (route) => false);
  }
}
