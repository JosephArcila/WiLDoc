import 'package:flutter/material.dart';
import 'package:wil_doc/utils/temp_data.dart';

class DocumentSummaryScreen extends StatefulWidget {
  const DocumentSummaryScreen({super.key});

  @override
  DocumentSummaryScreenState createState() => DocumentSummaryScreenState();
}

class DocumentSummaryScreenState extends State<DocumentSummaryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String extractedText = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    extractedText = TempData.extractedText ?? '';
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
              child: Text(extractedText),
            ),
          ),
          const Center(child: Text('Translation screen')),
          const Center(child: Text('Guide screen')),
        ],
      ),
    );
  }
}
