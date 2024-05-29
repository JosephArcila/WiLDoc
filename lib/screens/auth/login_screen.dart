import 'package:flutter/material.dart';
import 'package:wil_doc/screens/auth/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/screens/home/scan_document_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
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
    } catch (e) {
      // Handle sign-in error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: Theme.of(context).textTheme.titleLarge,
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
                  style: Theme.of(context).textTheme.bodyLarge,
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
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle forgotten password
                },
                child: Text(
                  'Forgotten password?',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              icon: const Icon(Icons.login, color: Colors.white),
              label: Text(
                'Sign In',
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary),
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
