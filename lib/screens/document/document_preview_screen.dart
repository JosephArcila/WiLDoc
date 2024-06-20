// ignore_for_file: avoid_web_libraries_in_flutter
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
  late List<String> _imagePaths;
  String extractedText = "Extracting text...";

  @override
  void initState() {
    super.initState();
    _imagePaths = List.from(widget.imagePaths);
    _extractTextFromFirstImage();
  }

  void _deletePage(int index) {
    setState(() {
      _imagePaths.removeAt(index);
    });
  }

  Future<void> _handleConfirm() async {
    // Show a loading indicator while text extraction is in progress
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Await text extraction
    final extractedText = await _extractTextFromFirstImage();

    // Hide the loading indicator
    if (mounted) {
      Navigator.pop(context);
    }

    // Store the extracted text in TempData
    TempData.extractedText = extractedText;

    final User? user = FirebaseAuth.instance.currentUser;
    if (mounted) {
      if (user != null) {
        // Navigate to the summary screen
        Navigator.pushReplacementNamed(context, AppRoutes.documentSummary);
      } else {
        // Navigate to the login screen
        Navigator.pushNamed(context, AppRoutes.login, arguments: {'redirectTo': AppRoutes.documentSummary});
      }
    }
  }

  Future<String> _extractTextFromFirstImage() async {
    try {
      if (_imagePaths.isNotEmpty) {
        final promise = js.context.callMethod('extractTextFromImage', [_imagePaths[0]]);
        final text = await promiseToFuture(promise);
        return text;
      }
    } catch (e) {
      return 'Failed to extract text: $e';
    }
    return '';
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
            child: ListView.builder(
              itemCount: _imagePaths.length + 1,
              itemBuilder: (context, index) {
                if (index == _imagePaths.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton.tonal(
                          onPressed: () {
                            Navigator.pop(context, _imagePaths);
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.document_scanner_outlined),
                              SizedBox(width: 8),
                              Text('Scan Additional Page'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_imagePaths[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Page ${index + 1}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _deletePage(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              onPressed: _handleConfirm,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check),
                  SizedBox(width: 8),
                  Text('Confirm'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}