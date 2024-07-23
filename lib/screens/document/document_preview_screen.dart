import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:wil_doc/utils/temp_data.dart';

class DocumentPreviewScreen extends StatelessWidget {
  final String imagePath;

  const DocumentPreviewScreen({super.key, required this.imagePath});

  Future<void> _handleConfirm(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      print('Starting text extraction...');
      print('Image path: $imagePath');
      final extractedText = await _extractTextFromImage(imagePath);
      print('Extracted text: $extractedText');

      if (context.mounted) {
        Navigator.pop(context); // Close loading dialog
      }

      TempData.extractedText = extractedText;

      final User? user = FirebaseAuth.instance.currentUser;
      if (context.mounted) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, AppRoutes.documentSummary);
        } else {
          Navigator.pushNamed(context, AppRoutes.login, arguments: {'redirectTo': AppRoutes.documentSummary});
        }
      }
    } catch (e) {
      print('Error during text extraction: $e');
      if (context.mounted) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error processing image: $e')),
        );
      }
    }
  }

  void _rescanAndClearTemp(BuildContext context) {
    TempData.extractedText = null;
    Navigator.pushReplacementNamed(context, AppRoutes.scanDocument);
  }

  Future<String> _extractTextFromImage(String imageDataUrl) async {
    try {
      print('Calling extractTextFromImage JavaScript function...');
      final promise = js.context.callMethod('extractTextFromImage', [imageDataUrl]);
      final text = await promiseToFuture(promise);
      print('Text extraction completed successfully');
      return text;
    } catch (e) {
      print('Error in _extractTextFromImage: $e');
      return 'Failed to extract text: $e';
    }
  }

  Future<String> promiseToFuture(js.JsObject promise) {
    final completer = Completer<String>();
    promise.callMethod('then', [
      (result) => completer.complete(result),
      (error) => completer.completeError(error)
    ]);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Document Preview'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _rescanAndClearTemp(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Preview your document and confirm to process',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Image.network(imagePath, fit: BoxFit.contain),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _rescanAndClearTemp(context),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Rescan'),
                  ),
                  FilledButton.icon(
                    onPressed: () => _handleConfirm(context),
                    icon: const Icon(Icons.check),
                    label: const Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}