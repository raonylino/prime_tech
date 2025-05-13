import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/view/profile/domain/usecases/change_password.dart';
import 'package:prime_pronta_resposta/src/view/profile/domain/usecases/get_user_profile.dart';
import 'package:prime_pronta_resposta/src/view/profile/domain/usecases/update_user_profile.dart';
import 'package:prime_pronta_resposta/src/view/profile/domain/usecases/upload_profile_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfile getUserProfileUseCase;
  final UpdateUserProfile updateUserProfileUseCase;
  final UploadProfileImage uploadProfileImageUseCase;
  final ChangePassword changePasswordUseCase;

  ProfileCubit({
    required this.getUserProfileUseCase,
    required this.updateUserProfileUseCase,
    required this.uploadProfileImageUseCase,
    required this.changePasswordUseCase,
  }) : super(ProfileInitial());

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final ImagePicker _picker = ImagePicker();

  Future<void> loadUserProfile() async {
    emit(ProfileLoading());

    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) {
        emit(ProfileError('Token não encontrado'));
        return;
      }

      final user = await getUserProfileUseCase(token);
      emit(
        ProfileLoaded(
          name: '${user.name}',
          email: '${user.email}',
          phone: '${user.phone}',
          imageUrl: '${user.imageProfilePath}',
        ),
      );
    } catch (e) {
      emit(ProfileError('Erro ao carregar perfil: ${e.toString()}'));
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

      await uploadProfileImageUseCase(token, imagePath);
      emit(ProfileImageUploadSuccess());
    } catch (e) {
      emit(ProfileError('Erro no upload de imagem: ${e.toString()}'));
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

      await updateUserProfileUseCase(token, name, email, phone);
      emit(ProfileUpdateSuccess("Perfil atualizado com sucesso"));
      await loadUserProfile();
    } catch (e) {
      emit(ProfileError("Erro ao atualizar perfil: ${e.toString()}"));
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

      await changePasswordUseCase(token, newPassword, confirmPassword);
      emit(ProfileUpdateSuccess("Senha alterada com sucesso!"));
    } catch (e) {
      emit(ProfileError("Erro ao alterar senha: ${e.toString()}"));
    }
  }

  Future<void> logout(BuildContext context) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
    navigator.pushNamedAndRemoveUntil(AppRouters.loginPage, (route) => false);
  }
}
