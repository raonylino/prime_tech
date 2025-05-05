
import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

@injectable

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<void> call(String email, String password) async {
    await repository.login(email, password);
  }
}
