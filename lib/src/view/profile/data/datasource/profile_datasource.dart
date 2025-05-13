import 'dart:io';

import 'package:dio/dio.dart';
import 'package:prime_pronta_resposta/src/view/profile/data/model/profile_model.dart';

abstract class ProfileDataSource {
  Future<ProfileModel> getUserProfile(String token);
  Future<void> updateUserProfile(
    String name,
    String email,
    String phone,
    String token,
  );
  Future<void> uploadProfileImage(String token, String imagePath);
  Future<void> changePassword(String token, String newPassword);
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final Dio dio;

  ProfileDataSourceImpl(this.dio);

  @override
  Future<ProfileModel> getUserProfile(String token) async {
    final response = await dio.get(
      '/user',
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.acceptHeader: 'application/json',
        },
      ),
    );

    if (response.statusCode == 200 && response.data['code'] == 1) {
      return ProfileModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Erro ao carregar perfil');
    }
  }

  @override
  Future<void> updateUserProfile(
    String token,
    String name,
    String email,
    String phone,
  ) async {
    final response = await dio.post(
      '/user',
      data: {'name': name, 'email': email, 'phone': phone},
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.acceptHeader: 'application/json',
        },
      ),
    );

    if (response.statusCode != 200 || response.data['code'] != 1) {
      throw Exception(response.data['message'] ?? 'Erro ao atualizar perfil');
    }
  }

  @override
  Future<void> uploadProfileImage(String token, String imagePath) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath, filename: 'profile.jpg'),
    });

    final response = await dio.post(
      '/user',
      data: formData,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.acceptHeader: 'application/json',
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro no upload: ${response.statusMessage}');
    }
  }

  @override
  Future<void> changePassword(String token, String newPassword) async {
    final response = await dio.post(
      '/user/password',
      data: {'password': newPassword},
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.acceptHeader: 'application/json',
        },
      ),
    );

    if (response.statusCode != 200 || response.data['code'] != 1) {
      throw Exception('Erro ao alterar a senha');
    }
  }
}
