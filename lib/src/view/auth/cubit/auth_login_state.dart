part of 'auth_login_cubit.dart';

@immutable
sealed class AuthLoginState {}

final class AuthLoginInitial extends AuthLoginState {}

final class AuthLoginLoading extends AuthLoginState {}

final class AuthLoginSuccess extends AuthLoginState {}

final class AuthLoginFailure extends AuthLoginState {
  final String message;

  AuthLoginFailure(this.message);
}
