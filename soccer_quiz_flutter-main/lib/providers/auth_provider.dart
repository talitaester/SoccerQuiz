import 'package:flutter/material.dart';
import '../domain/i_auth_repository.dart';

enum AuthState { idle, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final IAuthRepository authRepository;
  AuthProvider({required this.authRepository});

  AuthState state = AuthState.idle;
  String? error;
  Map<String,dynamic>? user;

  Future<void> checkAuth() async {
    state = AuthState.loading;
    notifyListeners();
    try {
      final logged = await authRepository.isLoggedIn();
      if (logged) {
        user = await authRepository.fetchProfile();
        state = AuthState.authenticated;
      } else {
        state = AuthState.unauthenticated;
      }
    } catch (e) {
      state = AuthState.error;
      error = e.toString();
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    state = AuthState.loading;
    error = null;
    notifyListeners();
    try {
      await authRepository.login(email, password);
      user = await authRepository.fetchProfile();
      state = AuthState.authenticated;
    } catch (e) {
      state = AuthState.error;
      error = e.toString();
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await authRepository.logout();
    user = null;
    state = AuthState.unauthenticated;
    notifyListeners();
  }
}