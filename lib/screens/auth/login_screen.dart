import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:wil_doc/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  final String? redirectTo;

  const LoginScreen({super.key, this.redirectTo});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _emailError;
  String? _passwordError;

  Future<void> _logIn() async {
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
        Navigator.pushReplacementNamed(context, widget.redirectTo ?? AppRoutes.scanDocument);
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
            _emailError = 'Log-in failed. ${e.message}';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log In',
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
                    Navigator.pushReplacementNamed(context, AppRoutes.register);
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: _emailController,
              labelText: 'Email',
              errorText: _emailError,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: _passwordController,
              labelText: 'Password',
              errorText: _passwordError,
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.resetPassword);
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
                'Log In',
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
              onPressed: _logIn,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
