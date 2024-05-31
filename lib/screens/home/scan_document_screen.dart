import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/screens/auth/account_screen.dart';
import 'package:wil_doc/screens/auth/login_screen.dart';
import 'package:wil_doc/screens/document/document_preview_screen.dart';
import 'package:wil_doc/utils/web_view_factory.dart';  // Import the web view factory
import 'dart:developer' as developer;

class ScanDocumentScreen extends StatefulWidget {
  const ScanDocumentScreen({super.key});

  @override
  State<ScanDocumentScreen> createState() => _ScanDocumentScreenState();
}

class _ScanDocumentScreenState extends State<ScanDocumentScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _takePicture() async {
    try {
      final imageDataUrl = await captureFrame();
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DocumentPreviewScreen(imagePath: imageDataUrl),
        ),
      );
    } catch (e) {
      developer.log('Error taking picture: $e');
    }
  }

  void _navigateToAccountOrLogin() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AccountScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('WiLDoc'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: _navigateToAccountOrLogin,
          ),
        ],
      ),
      body: const Center(
        child: SizedBox.expand(
          child: HtmlElementView(viewType: 'plugins.flutter.io/camera_1'),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: _takePicture,
        tooltip: 'Take Picture',
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
