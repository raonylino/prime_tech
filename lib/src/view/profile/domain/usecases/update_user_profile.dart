import 'package:prime_pronta_resposta/src/view/profile/domain/repositories/profile_repository.dart';

class UpdateUserProfile {
  final ProfileRepository repository;

  UpdateUserProfile(this.repository);

  Future<void> call(String name, String email, String phone) =>
      repository.updateUserProfile(name, email, phone);
}
