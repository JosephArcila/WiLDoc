import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/screens/auth/login_screen.dart';
import 'package:wil_doc/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _register() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      User? user = await _auth.registerWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        // Show error message
      }
    } else {
      // Show error message for password mismatch
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Already have an account?', style: Theme.of(context).textTheme.bodyLarge),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  child: Text('Sign in', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Email',
                labelStyle: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                labelStyle: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Confirm password',
                labelStyle: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _register,
              icon: const Icon(Icons.app_registration, color: Colors.white),
              label: Text('Register', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
