import 'package:prime_pronta_resposta/src/feature/profile/data/datasource/profile_datasource.dart';
import 'package:prime_pronta_resposta/src/feature/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getUserProfile();
  Future<void> updateUserProfile(String name, String email, String phone);
  Future<void> uploadProfileImage(String imagePath);
  Future<void> changePassword(String newPassword, String confirmPassword);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);
  @override
  Future<ProfileEntity> getUserProfile() async {
    return await remoteDataSource.getUserProfile();
  }

  @override
  Future<void> updateUserProfile(
    String name,
    String email,
    String phone,
  ) async {
    return await remoteDataSource.updateUserProfile(name, email, phone);
  }

  @override
  Future<void> uploadProfileImage(String imagePath) async {
    return await remoteDataSource.uploadProfileImage(imagePath);
  }

  @override
  Future<void> changePassword(
    String newPassword,
    String confirmPassword,
  ) async {
    return await remoteDataSource.changePassword(newPassword);
  }
}
