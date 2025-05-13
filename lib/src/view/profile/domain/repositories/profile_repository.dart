import 'package:prime_pronta_resposta/src/view/profile/data/datasource/profile_datasource.dart';
import 'package:prime_pronta_resposta/src/view/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getUserProfile(String token);
  Future<void> updateUserProfile(
    String name,
    String email,
    String phone,
    String token,
  );
  Future<void> uploadProfileImage(String imagePath, String token);
  Future<void> changePassword(
    String newPassword,
    String confirmPassword,
    String token,
  );
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);
  @override
  Future<ProfileEntity> getUserProfile(String token) async {
    return await remoteDataSource.getUserProfile(token);
  }

  @override
  Future<void> updateUserProfile(
    String name,
    String email,
    String phone,
    String token,
  ) async {
    return await remoteDataSource.updateUserProfile(name, email, phone, token);
  }

  @override
  Future<void> uploadProfileImage(String imagePath, String token) async {
    return await remoteDataSource.uploadProfileImage(imagePath, token);
  }

  @override
  Future<void> changePassword(
    String newPassword,
    String confirmPassword,
    String token,
  ) async {
    return await remoteDataSource.changePassword(token, newPassword);
  }
}
