import 'package:flutter/material.dart';

class DocumentPreviewScreen extends StatefulWidget {
  final List<String> imagePaths;

  const DocumentPreviewScreen({super.key, required this.imagePaths});

  @override
  DocumentPreviewScreenState createState() => DocumentPreviewScreenState();
}

class DocumentPreviewScreenState extends State<DocumentPreviewScreen> {
  late List<String> _imagePaths;

  @override
  void initState() {
    super.initState();
    _imagePaths = List.from(widget.imagePaths);
  }

  void _deletePage(int index) {
    setState(() {
      _imagePaths.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Preview'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _imagePaths.length + 1, // Add one for the button
              itemBuilder: (context, index) {
                if (index == _imagePaths.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton.tonal(
                          onPressed: () {
                            Navigator.pop(context, 'scan_more');
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
                return ListTile(
                  leading: Image.network(_imagePaths[index]),
                  title: Text('Page ${index + 1}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _deletePage(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context, 'confirm');
              },
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
