import 'package:flutter/material.dart';

class DocumentSummaryScreen extends StatelessWidget {
  const DocumentSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Document Scan'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Summary', icon: Icon(Icons.summarize_outlined)),
              Tab(text: 'Translation', icon: Icon(Icons.translate_outlined)),
              Tab(text: 'Guide', icon: Icon(Icons.support_outlined)),
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
