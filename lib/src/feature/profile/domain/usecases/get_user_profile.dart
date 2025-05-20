import 'package:prime_pronta_resposta/src/feature/profile/domain/entities/profile_entity.dart';
import 'package:prime_pronta_resposta/src/feature/profile/domain/repositories/profile_repository.dart';

class GetUserProfile {
  final ProfileRepository repository;

  GetUserProfile(this.repository);
  Future<ProfileEntity> call() => repository.getUserProfile();
}
