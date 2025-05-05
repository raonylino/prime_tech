abstract class AuthRemoteDataSource {
  Future<String> login(String email, String password);
  Future<bool> hasToken();
  Future<void> logout();
}
