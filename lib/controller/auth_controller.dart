import 'package:firebase_auth/firebase_auth.dart';
import '../service/auth_service.dart';

/// AuthController acts as a bridge between UI and Service
/// It coordinates the authentication operations
class AuthController {
  // Create an instance of AuthService
  final AuthService _service = AuthService();

  /// Register a new user
  /// This method calls the service and returns the result
  Future<User?> register(String email, String password) async {
    // Call the signUp method from AuthService
    return await _service.signUp(email, password);
  }

  /// Login an existing user
  Future<User?> login(String email, String password) async {
    // Call the login method from AuthService
    return await _service.login(email, password);
  }

  /// Logout current user
  Future<void> logout() async {
    await _service.logout();
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return _service.isUserLoggedIn();
  }

  /// Get current user
  User? getCurrentUser() {
    return _service.getCurrentUser();
  }
}