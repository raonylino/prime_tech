abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<bool> checkLoginStatus();
  Future<void> logout();
}
