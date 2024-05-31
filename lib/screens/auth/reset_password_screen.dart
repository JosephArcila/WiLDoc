import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wil_doc/services/auth_service.dart';
import 'package:wil_doc/widgets/custom_text_field.dart'; // Import the custom text field

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _emailController,
              labelText: 'Email',
              errorText: _emailError,
              keyboardType: TextInputType.emailAddress,
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
