import 'package:injectable/injectable.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/repositories/auth_repository.dart';

@injectable
class LogoutUseCase {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  Future<void> call() async {
    await repository.logout();
  }
}
