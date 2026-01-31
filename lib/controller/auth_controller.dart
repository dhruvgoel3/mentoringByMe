import 'package:firebase_auth/firebase_auth.dart';
import '../service/auth_service.dart';


class AuthController {
  final AuthService _service = AuthService();

  Future<User?> register(String email, String pass) {
    return _service.signUp(email, pass);
  }

  Future<User?> login(String email, String pass) {
    return _service.login(email, pass);
  }
}