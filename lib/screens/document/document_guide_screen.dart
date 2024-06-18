import 'package:flutter/material.dart';

class DocumentGuideScreen extends StatelessWidget {
  const DocumentGuideScreen({super.key});

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
                'In step 1, write your name:\n[Sanjay Bandari]',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'In step 2, write your date of birth:\n[1990/01/01]',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'In step 3, write your address:\n[123 Main St, Tokyo, Japan]',
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
