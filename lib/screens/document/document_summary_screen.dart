import 'package:flutter/material.dart';

class DocumentSummaryScreen extends StatelessWidget {
  const DocumentSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Document Scan'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Summary', icon: Icon(Icons.description)),
              Tab(text: 'Translation', icon: Icon(Icons.translate)),
              Tab(text: 'Guide', icon: Icon(Icons.help_outline)),
            ],
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
