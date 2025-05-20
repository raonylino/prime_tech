import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';

@injectable
class CheckLoginStatusUseCase {
  final AuthRepository repository;
  CheckLoginStatusUseCase(this.repository);

  Future<bool> call() async {
    return await repository.checkLoginStatus();
  }
}
