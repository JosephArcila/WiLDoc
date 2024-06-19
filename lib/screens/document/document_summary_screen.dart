// /Users/joseph/projects/wil_doc/lib/screens/document/document_summary_screen.dart
import 'package:flutter/material.dart';

class DocumentSummaryScreen extends StatefulWidget {
  final String extractedText;

  const DocumentSummaryScreen({super.key, required this.extractedText});

  @override
  DocumentSummaryScreenState createState() => DocumentSummaryScreenState();
}

class DocumentSummaryScreenState extends State<DocumentSummaryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Document Scan'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Summary',
              icon: Icon(_tabController.index == 0 ? Icons.summarize : Icons.summarize_outlined),
            ),
            Tab(
              text: 'Translation',
              icon: Icon(_tabController.index == 1 ? Icons.translate : Icons.translate_outlined),
            ),
            Tab(
              text: 'Guide',
              icon: Icon(_tabController.index == 2 ? Icons.support : Icons.support_outlined),
            ),
          ],
          onTap: (index) {
            setState(() {});
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(widget.extractedText),
            ),
          ),
          const Center(child: Text('Translation screen')),
          const Center(child: Text('Guide screen')),
        ],
      ),
    );
  }
}
