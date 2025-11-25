abstract class IAuthRepository {
  Future<String> login(String email, String password); // returns token
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<Map<String,dynamic>?> fetchProfile();
}