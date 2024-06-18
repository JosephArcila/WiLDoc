import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:wil_doc/utils/web_view_factory.dart';
import 'dart:developer' as developer;

class ScanDocumentScreen extends StatefulWidget {
  const ScanDocumentScreen({super.key});

  @override
  State<ScanDocumentScreen> createState() => _ScanDocumentScreenState();
}

class _ScanDocumentScreenState extends State<ScanDocumentScreen> {
  List<String> scannedPages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkProfileCompletion());
  }

  void _checkProfileCompletion() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (mounted) {
          if (userDoc.exists) {
            final data = userDoc.data();

            bool isProfileComplete = true;
            List<String> missingFields = [];

            if (data?['full_name'] == null) {
              isProfileComplete = false;
              missingFields.add('full_name');
            }
            if (data?['nationality'] == null) {
              isProfileComplete = false;
              missingFields.add('nationality');
            }
            if (data?['visa_status'] == null) {
              isProfileComplete = false;
              missingFields.add('visa_status');
            }
            if (data?['duration_of_stay'] == null) {
              isProfileComplete = false;
              missingFields.add('duration_of_stay');
            }
            if (data?['prefecture'] == null) {
              isProfileComplete = false;
              missingFields.add('prefecture');
            }
            if (data?['ward'] == null) {
              isProfileComplete = false;
              missingFields.add('ward');
            }
            if (data?['japanese_proficiency'] == null) {
              isProfileComplete = false;
              missingFields.add('japanese_proficiency');
            }

            developer.log('Missing fields: ${missingFields.join(', ')}');
            developer.log('Is profile complete: $isProfileComplete');

            if (!isProfileComplete) {
              Navigator.pushReplacementNamed(context, AppRoutes.profilesetup);
            }
          } else {
            Navigator.pushReplacementNamed(context, AppRoutes.profilesetup);
          }
        }
      } catch (e) {
        developer.log('Error checking profile completion: $e');
      }
    }
  }

  void _takePicture() async {
    try {
      final imageDataUrl = await captureFrame();
      if (!mounted) return;
      setState(() {
        scannedPages.add(imageDataUrl);
      });
      final result = await Navigator.pushNamed(
        context,
        AppRoutes.documentPreview,
        arguments: {'imagePaths': scannedPages},
      );
      if (result == 'scan_more') {
        // Continue scanning additional pages
      } else if (result is List<String>) {
        // Update the scanned pages list after returning from preview
        setState(() {
          scannedPages = result;
        });
      }
    } catch (e) {
      developer.log('Error taking picture: $e');
    }
  }

  void _navigateToAccountOrLogin() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushNamed(context, AppRoutes.account);
    } else {
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
