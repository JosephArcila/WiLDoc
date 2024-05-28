import 'package:flutter/material.dart';

class DocumentPreviewScreen extends StatelessWidget {
  final String imagePath;

  const DocumentPreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Preview')),
      body: Image.network(imagePath),
    );
  }
}
