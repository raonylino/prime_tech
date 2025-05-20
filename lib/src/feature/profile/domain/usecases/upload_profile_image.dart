import 'package:prime_pronta_resposta/src/feature/profile/domain/repositories/profile_repository.dart';

class UploadProfileImage {
  final ProfileRepository repository;

  UploadProfileImage(this.repository);

  Future<void> call(String imagePath) =>
      repository.uploadProfileImage(imagePath);
}
