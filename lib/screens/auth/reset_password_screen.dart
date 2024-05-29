import 'package:flutter/material.dart';
import 'package:wil_doc/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final AuthService _authService = AuthService();

  String? _emailError;

  Future<void> _resetPassword() async {
    setState(() {
      _emailError = null;
    });

    try {
      await _authService.sendPasswordResetEmail(_emailController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent')),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() {
        switch (e.code) {
          case 'invalid-email':
            _emailError = 'Invalid email address. Check and try again.';
            break;
          case 'user-not-found':
            _emailError = 'No user found for that email.';
            break;
          default:
            _emailError = 'Failed to send reset email. ${e.message}';
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
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Email',
                errorText: _emailError,
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
            const Spacer(),
            FilledButton.icon(
              onPressed: _resetPassword,
              icon: const Icon(Icons.email, color: Colors.white),
              label: Text('Send Reset Email', style: TextStyle(color: theme.colorScheme.onPrimary)),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
