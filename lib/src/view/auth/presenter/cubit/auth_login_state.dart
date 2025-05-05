part of 'auth_login_cubit.dart';

@immutable
abstract class AuthLoginState {}

class AuthLoginInitial extends AuthLoginState {}

class AuthLoginLoading extends AuthLoginState {}

class AuthLoginSuccess extends AuthLoginState {}

class AuthLoginFailure extends AuthLoginState {
  final String message;
  AuthLoginFailure(this.message);
}
