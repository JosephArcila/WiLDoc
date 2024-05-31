import 'package:flutter/material.dart';

class DocumentTranslationScreen extends StatelessWidget {
  const DocumentTranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Translation'),
      ),
      body: const Center(
        child: Text('This is the document translation screen.'),
      ),
    );
  }
}
