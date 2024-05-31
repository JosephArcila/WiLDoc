import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:wil_doc/widgets/custom_text_field.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _visaStatusController = TextEditingController();
  final TextEditingController _durationOfStayController = TextEditingController();
  final TextEditingController _prefectureController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _japaneseProficiencyController = TextEditingController();

  Future<void> _completeProfile() async {
    // Logic to save user profile information goes here
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, AppRoutes.scanDocument);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tell Us About Yourself', style: theme.textTheme.titleLarge),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _fullNameController,
              labelText: 'Full Name',
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: _nationalityController,
              labelText: 'Nationality',
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: _visaStatusController,
              labelText: 'Visa Status',
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: _durationOfStayController,
              labelText: 'Duration of Stay',
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: _prefectureController,
              labelText: 'Prefecture',
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: _wardController,
              labelText: 'Ward',
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: _japaneseProficiencyController,
              labelText: 'Japanese Proficiency',
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _completeProfile,
              icon: const Icon(Icons.done, color: Colors.white),
              label: Text('Finish', style: TextStyle(color: theme.colorScheme.onPrimary)),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
