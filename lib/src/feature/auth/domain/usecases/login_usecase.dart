import 'package:prime_pronta_resposta/src/feature/auth/domain/entities/login_entities.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<LoginEntity> call(String email, String password) async {
    final result = await repository.login(email, password);
    return result.fold(
      (failure) => throw failure,
      (loginEntity) => loginEntity,
    );
  }
}
