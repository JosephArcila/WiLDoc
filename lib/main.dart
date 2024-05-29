import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/screens/home/scan_document_screen.dart';
import 'package:wil_doc/screens/auth/login_screen.dart';
import 'package:wil_doc/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBDo5W2woIYsKuycY5mkpVDDmen5R8TYlI",
      authDomain: "wildocjapan.firebaseapp.com",
      projectId: "wildocjapan",
      storageBucket: "wildocjapan.appspot.com",
      messagingSenderId: "355560021631",
      appId: "1:355560021631:web:212af7d0257ef096b3294a",
      measurementId: "G-0PPQWPM7DD"
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WiLDoc',
      theme: lightHighContrastTheme,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const ScanDocumentScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
