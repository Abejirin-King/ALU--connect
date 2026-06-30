import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../navigation/screens/main_navigation_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedRole = "student"; // "student" or "startup"
  bool _isLoading = false;
  String? _errorMessage;
  bool _obscurePassword = true;

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      // Save user with role to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'role': _selectedRole,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = e.message);
    } catch (e) {
      setState(() => _errorMessage = "Signup failed. Please try again.");
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.royalBlue, AppColors.red],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(Icons.school, size: 70, color: Colors.white),
                  const SizedBox(height: 16),
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Role Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text("Student"),
                        selected: _selectedRole == "student",
                        onSelected: (selected) {
                          setState(() => _selectedRole = "student");
                        },
                      ),
                      const SizedBox(width: 16),
                      ChoiceChip(
                        label: const Text("Startup"),
                        selected: _selectedRole == "startup",
                        onSelected: (selected) {
                          setState(() => _selectedRole = "startup");
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if (_errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),

                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: "Full Name",
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) => value == null || value.trim().isEmpty
                                  ? "Please enter your name"
                                  : null,
                            ),

                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => value == null || !value.contains('@')
                                  ? "Enter a valid email"
                                  : null,
                            ),

                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() => _obscurePassword = !_obscurePassword);
                                  },
                                ),
                              ),
                              validator: (value) => value == null || value.length < 6
                                  ? "Password must be at least 6 characters"
                                  : null,
                            ),

                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _signup,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.red,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: _isLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : const Text("Sign Up", style: TextStyle(fontSize: 16)),
                              ),
                            ),

                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Already have an account? Login"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}