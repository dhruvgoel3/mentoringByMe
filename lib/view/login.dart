import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoring_meet_1/view/sign_up.dart';
import '../HomePage.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers to get text from TextField
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  // Auth controller to handle login
  final controller = AuthController();

  // Loading state - shows progress indicator when true
  bool loading = false;

  /// Login Method
  /// This is called when user presses Login button
  void login() async {
    // Validate input first
    if (emailCtrl.text.trim().isEmpty || passCtrl.text.trim().isEmpty) {
      _showMessage('Please enter email and password', isError: true);
      return;
    }

    // Show loading indicator
    setState(() => loading = true);

    // Try to login
    final user = await controller.login(
      emailCtrl.text.trim(),
      passCtrl.text.trim(),
    );

    // Hide loading indicator
    setState(() => loading = false);

    // Check if login was successful
    if (user != null) {
      _showMessage('Login Success! Welcome ${user.email}');

      // Navigate to Home Screen
      Get.offAll(() => const HomeScreen());
    } else {
      _showMessage('Login Failed. Check your credentials.', isError: true);
    }
  }

  /// Show message to user
  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controllers when screen is disposed
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo or Title
                const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
                const SizedBox(height: 20),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),

                // Email TextField
                TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password TextField
                TextField(
                  controller: passCtrl,
                  obscureText: true, // Hide password
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Login Button or Loading Indicator
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: loading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                ),
                const SizedBox(height: 16),

                // Navigate to Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const SignupScreen());
                      },
                      child: const Text(
                        'Create Account',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
