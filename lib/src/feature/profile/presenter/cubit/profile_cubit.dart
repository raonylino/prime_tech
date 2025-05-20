import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/feature/profile/domain/usecases/change_password.dart';
import 'package:prime_pronta_resposta/src/feature/profile/domain/usecases/get_user_profile.dart';
import 'package:prime_pronta_resposta/src/feature/profile/domain/usecases/update_user_profile.dart';
import 'package:prime_pronta_resposta/src/feature/profile/domain/usecases/upload_profile_image.dart';
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

  final ImagePicker _picker = ImagePicker();

  Future<void> loadUserProfile() async {
    emit(ProfileLoading());

    try {
      final user = await getUserProfileUseCase();
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
      await uploadProfileImageUseCase(imagePath);
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
      await updateUserProfileUseCase(name, email, phone);
      emit(ProfileUpdateSuccess("Perfil atualizado com sucesso"));
      await loadUserProfile();
    } catch (e) {
      emit(ProfileError("Erro ao atualizar perfil: ${e.toString()}"));
    }
  }

  Future<void> changePassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ProfileLoading());

    if (newPassword != confirmPassword) {
      emit(ProfileError("As senhas não coincidem."));
      return;
    }

    try {
      await changePasswordUseCase(newPassword, confirmPassword);
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
