import 'package:flutter/material.dart';

class DocumentPreviewScreen extends StatelessWidget {
  final List<String> imagePaths;

  const DocumentPreviewScreen({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Preview')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(imagePaths[index]),
                  title: Text('Page ${index + 1}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Handle deletion of a scanned page
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'scan_more');
                  },
                  child: const Text('Scan Additional Page'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'confirm');
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
