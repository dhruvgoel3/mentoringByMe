import 'package:firebase_auth/firebase_auth.dart';

/// AuthService handles all Firebase Authentication operations
/// This is where we directly communicate with Firebase
class AuthService {
  // Create an instance of FirebaseAuth
  // This is like getting a phone to call Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign Up - Create new account
  /// Takes email and password, returns User if successful
  Future<User?> signUp(String email, String password) async {
    try {
      // Ask Firebase to create a new account
      final UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password,
      );

      // Return the user information
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase errors
      print("Sign Up Error");

      // You can handle specific errors here
      if (e.code == 'weak-password') {
        print('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists for this email.');
      }

      return null;
    } catch (e) {
      // Handle any other errors
      print('❌ Unexpected Error: $e');
      return null;
    }
  }

  /// Login - Sign in existing user
  /// Takes email and password, returns User if successful
  Future<User?> login(String email, String password) async {
    try {
      // Ask Firebase to sign in the user
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return the user information
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase errors
      print('❌ Login Error: ${e.code} - ${e.message}');

      if (e.code == 'user-not-found') {
        print('No user found for this email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }

      return null;
    } catch (e) {
      // Handle any other errors
      print('❌ Unexpected Error: $e');
      return null;
    }
  }

  /// Logout - Sign out current user
  Future<void> logout() async {
    try {
      await _auth.signOut();
      print('✅ User logged out successfully');
    } catch (e) {
      print('❌ Logout Error: $e');
    }
  }

  /// Get Current User
  /// Returns the currently logged in user, or null if not logged in
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Check if user is logged in
  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }
}
