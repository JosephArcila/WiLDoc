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

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  Future<void> _register() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });

    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        User? user = await _auth.registerWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
        if (user != null && mounted) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        setState(() {
          switch (e.code) {
            case 'email-already-in-use':
              _emailError = 'Email already in use. Use another or login.';
              break;
            case 'weak-password':
              _passwordError = 'Password too weak. Use a stronger password.';
              break;
            case 'invalid-email':
              _emailError = 'Invalid email address. Check and try again.';
              break;
            default:
              _emailError = 'Registration failed. ${e.message}';
          }
        });
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _emailError = 'Unexpected error: $e';
        });
      }
    } else {
      setState(() {
        _confirmPasswordError = 'Passwords do not match. Re-enter passwords.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;
    final onSurfaceColor = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: theme.textTheme.titleLarge),
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
                Text('Already have an account?', style: theme.textTheme.bodyLarge),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text('Sign in', style: TextStyle(color: theme.colorScheme.primary)),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Email',
                errorText: _emailError,
                errorMaxLines: 2, // Allow error message to wrap to multiple lines
                errorStyle: TextStyle(color: errorColor),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: errorColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: errorColor),
                ),
                labelStyle: TextStyle(color: _emailError != null ? errorColor : onSurfaceColor),
              ),
              style: TextStyle(color: onSurfaceColor),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                errorText: _passwordError,
                errorMaxLines: 2, // Allow error message to wrap to multiple lines
                errorStyle: TextStyle(color: errorColor),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: errorColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: errorColor),
                ),
                labelStyle: TextStyle(color: _passwordError != null ? errorColor : onSurfaceColor),
              ),
              style: TextStyle(color: onSurfaceColor),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Confirm password',
                errorText: _confirmPasswordError,
                errorMaxLines: 2, // Allow error message to wrap to multiple lines
                errorStyle: TextStyle(color: errorColor),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: errorColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: errorColor),
                ),
                labelStyle: TextStyle(color: _confirmPasswordError != null ? errorColor : onSurfaceColor),
              ),
              style: TextStyle(color: onSurfaceColor),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _register,
              icon: const Icon(Icons.app_registration, color: Colors.white),
              label: Text('Register', style: TextStyle(color: theme.colorScheme.onPrimary)),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
