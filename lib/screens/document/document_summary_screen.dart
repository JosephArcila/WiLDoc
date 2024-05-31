import 'package:flutter/material.dart';

class DocumentSummaryScreen extends StatelessWidget {
  const DocumentSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Summary'),
      ),
      body: const Center(
        child: Text('This is the document summary screen.'),
      ),
    );
  }
}
