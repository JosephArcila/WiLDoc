import 'package:flutter/material.dart';
import 'package:wil_doc/screens/auth/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/screens/home/scan_document_screen.dart';
import 'package:wil_doc/screens/auth/reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _emailError;
  String? _passwordError;

  Future<void> _signIn() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScanDocumentScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() {
        switch (e.code) {
          case 'user-not-found':
            _emailError = 'No user found for that email. Check email or register.';
            break;
          case 'wrong-password':
            _passwordError = 'Incorrect password. Try again or reset.';
            break;
          default:
            _emailError = 'Sign-in failed. ${e.message}';
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _emailError = 'Unexpected error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;
    final onErrorColor = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: theme.textTheme.titleLarge,
        ),
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
                Text(
                  'Don\'t have an account?',
                  style: theme.textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
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
                labelStyle: TextStyle(color: _emailError != null ? errorColor : null),
              ),
              style: TextStyle(color: onErrorColor),
              cursorColor: errorColor,
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
                labelStyle: TextStyle(color: _passwordError != null ? errorColor : null),
              ),
              style: TextStyle(color: onErrorColor),
              cursorColor: errorColor,
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                  );
                },
                child: Text(
                  'Forgotten password?',
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              icon: const Icon(Icons.login, color: Colors.white),
              label: Text(
                'Sign In',
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
              onPressed: _signIn,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
