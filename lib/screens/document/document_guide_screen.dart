import 'package:flutter/material.dart';

class DocumentGuideScreen extends StatelessWidget {
  const DocumentGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Guide'),
      ),
      body: const Center(
        child: Text('This is the document guide screen.'),
      ),
    );
  }
}
