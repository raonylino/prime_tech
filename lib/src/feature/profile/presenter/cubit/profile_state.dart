part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String imageUrl;
  final String phone;

  ProfileLoaded({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.phone,
  });
}

class ProfileUpdateSuccess extends ProfileState {
  final String message;
  ProfileUpdateSuccess(this.message);
}

class ProfileImagePicked extends ProfileState {
  final String imagePath;
  ProfileImagePicked(this.imagePath);
}

class ProfileImageUploadSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
