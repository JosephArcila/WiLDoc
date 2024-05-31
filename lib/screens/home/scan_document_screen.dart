import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/routes/app_routes.dart'; // Import the app routes
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
      Navigator.pushNamed(
        context,
        AppRoutes.documentPreview,
        arguments: {'imagePath': imageDataUrl}, // Pass arguments
      );
    } catch (e) {
      developer.log('Error taking picture: $e');
    }
  }

  void _navigateToAccountOrLogin() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushNamed(context, AppRoutes.account); // Use named route
    } else {
      Navigator.pushNamed(context, AppRoutes.login); // Use named route
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
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
