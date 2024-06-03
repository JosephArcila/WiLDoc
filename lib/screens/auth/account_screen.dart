import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/services/auth_service.dart';
import 'package:wil_doc/services/firestore_service.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:wil_doc/models/user.dart' as model;

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  final AuthService _authService = AuthService();
  model.User? _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final user = await FirestoreService().getUser(userId);
    setState(() {
      _user = user;
    });
  }

  void _signOut() async {
    await _authService.signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_user != null) ...[
              Text('Email: ${_user!.email}', style: Theme.of(context).textTheme.bodyLarge),
              Text('Full Name: ${_user!.fullName}', style: Theme.of(context).textTheme.bodyLarge),
              // Display other user information as needed
            ],
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
        ),
      ),
    );
  }
}
