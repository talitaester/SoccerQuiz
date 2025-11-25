import '../../domain/i_auth_repository.dart';
import '../api/api_client.dart';
import 'dart:convert';

class AuthRepository implements IAuthRepository {
  final ApiClient apiClient;
  AuthRepository({required this.apiClient});

  @override
  Future<String> login(String email, String password) async {
    final res = await apiClient.post('/auth/login', {'email': email, 'password': password});
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final token = json['token'] as String?;
    if (token == null) throw Exception('token missing in response');
    await apiClient.saveToken(token);
    return token;
  }

  @override
  Future<void> logout() async {
    // Optionally call server logout
    await apiClient.clearToken();
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await apiClient.secureStorage.read(key: 'auth_token');
    return token != null;
  }

  @override
  Future<Map<String, dynamic>?> fetchProfile() async {
    final res = await apiClient.get('/user/me');
    return jsonDecode(res.body) as Map<String, dynamic>?;
  }
}