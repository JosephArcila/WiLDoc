import 'package:flutter/material.dart';

class DocumentTranslationScreen extends StatelessWidget {
  const DocumentTranslationScreen({super.key});

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
              Tab(text: 'Summary', icon: Icon(Icons.description)),
              Tab(text: 'Translation', icon: Icon(Icons.translate)),
              Tab(text: 'Guide', icon: Icon(Icons.help_outline)),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'English translation..',
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add functionality here
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Resolve'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
