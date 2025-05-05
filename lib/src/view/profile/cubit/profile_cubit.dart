import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final String baseUrl = dotenv.env['BASE_URL']!;

  final ImagePicker _picker = ImagePicker();

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

          emit(
            ProfileLoaded(
              name: name,
              email: email,
              imageUrl: imageUrl,
              phone: phone,
            ),
          );
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

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        emit(ProfileImagePicked(pickedFile.path));
        await uploadProfileImage(pickedFile.path);
        await loadUserProfile();
      }
    } catch (e) {
      emit(ProfileError('Erro ao selecionar imagem: ${e.toString()}'));
    }
  }

  Future<void> uploadProfileImage(String imagePath) async {
    emit(ProfileLoading());
    try {
      final token = await _storage.read(key: 'auth_token');

      if (token == null) {
        emit(ProfileError('Token não encontrado'));
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/user'));

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.files.add(await http.MultipartFile.fromPath('image', imagePath));

      final response = await request.send();

      if (response.statusCode == 200) {
        emit(ProfileImageUploadSuccess());
      } else {
        final responseBody = await response.stream.bytesToString();
        emit(ProfileError('Erro no upload: $responseBody'));
      }
    } catch (e) {
      emit(ProfileError('Erro ao enviar imagem: ${e.toString()}'));
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(ProfileLoading());

    try {
      final token = await _storage.read(key: 'auth_token');

      if (token == null) {
        emit(ProfileError('Token não encontrado'));
        return;
      }

      Map<String, String> updatedFields = {};

      if (name.isNotEmpty) updatedFields['name'] = name;
      if (email.isNotEmpty) updatedFields['email'] = email;
      if (phone.isNotEmpty) updatedFields['phone'] = phone;

      final response = await http.post(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: updatedFields,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['code'] == 1) {
          emit(ProfileUpdateSuccess(data['message']));
          await loadUserProfile();
        } else {
          emit(ProfileError(data['message']));
        }
      } else {
        emit(ProfileError('Erro: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProfileError('Erro ao atualizar perfil: ${e.toString()}'));
    }
  }

  Future<void> changePassword(
    String newPassword,
    String confirmPassword,
  ) async {
    emit(ProfileLoading());

    if (newPassword != confirmPassword) {
      emit(ProfileError("As senhas não coincidem."));
      return;
    }
    try {
      final token = await _storage.read(key: 'auth_token');

      if (token == null) {
        emit(ProfileError('Token não encontrado'));
        return;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        emit(ProfileUpdateSuccess("Senha alterada com sucesso!"));
      } else {
        emit(
          ProfileError(
            "Erro ao alterar a senha. Código ${response.statusCode}",
          ),
        );
      }
    } catch (e) {
      emit(ProfileError("Erro: ${e.toString()}"));
    }
  }

  void logout(BuildContext context) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    navigator.pushNamedAndRemoveUntil(AppRouters.loginPage, (route) => false);
  }
}
