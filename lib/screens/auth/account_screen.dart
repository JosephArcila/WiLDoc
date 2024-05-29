import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/screens/auth/login_screen.dart';
import 'package:wil_doc/services/auth_service.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  final AuthService _authService = AuthService();

  void _signOut() async {
    await _authService.signOut();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user != null) ...[
              Text('Email: ${user.email}', style: Theme.of(context).textTheme.bodyLarge),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: FilledButton.tonalIcon(
                  onPressed: _signOut,
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: Text(
                    'Logout',
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ],
        ),
      ),
    );
  }
}
