import 'package:flutter/material.dart';
import 'package:wil_doc/utils/temp_data.dart';
import 'package:wil_doc/services/langchain_openai_service.dart';

class DocumentSummaryScreen extends StatefulWidget {
  const DocumentSummaryScreen({super.key});

  @override
  DocumentSummaryScreenState createState() => DocumentSummaryScreenState();
}

class DocumentSummaryScreenState extends State<DocumentSummaryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String extractedText = '';
  String translatedText = '';
  bool isTranslating = false;
  late OpenAIService _openAIService;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    extractedText = TempData.extractedText ?? '';
    _openAIService = OpenAIService(); // Remove the argument here
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  Future<void> _translateText() async {
    if (!mounted) return;
    setState(() {
      isTranslating = true;
    });

    try {
      final translated = await _openAIService.translateText(extractedText, 'English');
      if (!mounted) return;
      setState(() {
        translatedText = translated;
        isTranslating = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isTranslating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Translation failed: $e')),
      );
    }
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
          ],
          onTap: (index) {
            setState(() {});
            if (index == 1 && translatedText.isEmpty && !isTranslating) {
              _translateText();
            }
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Text(extractedText),
            ),
          ),
          Center(
            child: isTranslating
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(translatedText.isEmpty ? 'Tap to translate' : translatedText),
                  ),
          ),
        ],
      ),
    );
  }
}