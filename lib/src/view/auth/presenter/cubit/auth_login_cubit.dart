import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/usecases/check_login_status_usecase.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/usecases/login_usecase.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/usecases/logout_usecase.dart';

part 'auth_login_state.dart';

class AuthLoginCubit extends Cubit<AuthLoginState> {
  final LoginUseCase loginUseCase;
  final CheckLoginStatusUseCase checkLoginStatusUseCase;
  final LogoutUseCase logoutUseCase;

  AuthLoginCubit({
    required this.loginUseCase,
    required this.checkLoginStatusUseCase,
    required this.logoutUseCase,
  }) : super(AuthLoginInitial());

  void login(String email, String password) async {
    emit(AuthLoginLoading());
    try {
      await loginUseCase(email, password);
      emit(AuthLoginSuccess());
    } catch (e) {
      emit(AuthLoginFailure(e.toString()));
    }
  }

  void checkLoginStatus() async {
    emit(AuthLoginLoading());
    final loggedIn = await checkLoginStatusUseCase();
    emit(loggedIn ? AuthLoginSuccess() : AuthLoginInitial());
  }

  void logout() async {
    await logoutUseCase();
    emit(AuthLoginInitial());
  }
}
