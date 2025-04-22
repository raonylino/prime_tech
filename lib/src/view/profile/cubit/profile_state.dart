part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String email;

  ProfileLoaded({required this.name, required this.email});
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
