import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../HomePage.dart';
import '../controller/auth_controller.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controllers to get text from TextField
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  // Auth controller to handle signup
  final controller = AuthController();

  // Loading state
  bool loading = false;

  /// Sign Up Method
  /// This is called when user presses Sign Up button
  void signUp() async {
    // Validate input
    if (emailCtrl.text.trim().isEmpty ||
        passCtrl.text.trim().isEmpty ||
        confirmPassCtrl.text.trim().isEmpty) {
      _showMessage('Please fill all fields', isError: true);
      return;
    }

    // Check if passwords match
    if (passCtrl.text.trim() != confirmPassCtrl.text.trim()) {
      _showMessage('Passwords do not match', isError: true);
      return;
    }

    // Check password length
    if (passCtrl.text.trim().length < 6) {
      _showMessage('Password must be at least 6 characters', isError: true);
      return;
    }

    // Show loading indicator
    setState(() => loading = true);

    // Try to create account
    final user = await controller.register(
      emailCtrl.text.trim(),
      passCtrl.text.trim(),
    );

    // Hide loading indicator
    setState(() => loading = false);

    // Check if signup was successful
    if (user != null) {
      _showMessage('Account created successfully!');

      // Navigate to Home Screen
      Get.offAll(() => const HomeScreen());
    } else {
      _showMessage('Sign up failed. Email may already be in use.', isError: true);
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
    // Clean up controllers
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo or Title
                const Icon(
                  Icons.person_add_outlined,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Join Us Today!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
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
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm Password TextField
                TextField(
                  controller: confirmPassCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Sign Up Button or Loading Indicator
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: loading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Navigate to Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    TextButton(
                      onPressed: () {
                        Get.back(); // Go back to login screen
                      },
                      child: const Text(
                        'Login',
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