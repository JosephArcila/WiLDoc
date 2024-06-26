import 'dart:async';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:wil_doc/utils/temp_data.dart';

class DocumentPreviewScreen extends StatefulWidget {
  final List<String> imagePaths;

  const DocumentPreviewScreen({super.key, required this.imagePaths});

  @override
  DocumentPreviewScreenState createState() => DocumentPreviewScreenState();
}

class DocumentPreviewScreenState extends State<DocumentPreviewScreen> {
  late String _imagePath;
  String extractedText = "Extracting text...";

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imagePaths.first;
    _extractTextFromImage();
  }

  Future<void> _handleConfirm() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final extractedText = await _extractTextFromImage();

    if (mounted) {
      Navigator.pop(context);
    }

    TempData.extractedText = extractedText;

    final User? user = FirebaseAuth.instance.currentUser;
    if (mounted) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, AppRoutes.documentSummary);
      } else {
        Navigator.pushNamed(context, AppRoutes.login, arguments: {'redirectTo': AppRoutes.documentSummary});
      }
    }
  }

  Future<String> _extractTextFromImage() async {
    try {
      final promise = js.context.callMethod('extractTextFromImage', [_imagePath]);
      final text = await promiseToFuture(promise);
      return text;
    } catch (e) {
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
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_imagePath),
                            fit: BoxFit.contain,
                          ),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Please confirm that the document is clear and readable.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Rescan'),
                ),
                FilledButton.icon(
                  onPressed: _handleConfirm,
                  icon: const Icon(Icons.check),
                  label: const Text('Confirm'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}