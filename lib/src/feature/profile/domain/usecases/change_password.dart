import 'package:prime_pronta_resposta/src/feature/profile/domain/repositories/profile_repository.dart';

class ChangePassword {
  final ProfileRepository repository;

  ChangePassword(this.repository);

  Future<void> call(String newPassword, String confirmPassword) =>
      repository.changePassword(newPassword, confirmPassword);
}
