import 'package:flutter/material.dart';
import 'package:wil_doc/utils/temp_data.dart';
import 'package:wil_doc/services/langchain_openai_service.dart';
import 'package:wil_doc/routes/app_routes.dart';

class DocumentSummaryScreen extends StatefulWidget {
  const DocumentSummaryScreen({super.key});

  @override
  DocumentSummaryScreenState createState() => DocumentSummaryScreenState();
}

class DocumentSummaryScreenState extends State<DocumentSummaryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String extractedText = '';
  String translatedText = '';
  String summarizedText = '';
  bool isTranslating = false;
  bool isSummarizing = false;
  late OpenAIService _openAIService;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    extractedText = TempData.extractedText ?? '';
    _openAIService = OpenAIService();
    _summarizeText();
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

  Future<void> _summarizeText() async {
    if (!mounted) return;
    setState(() {
      isSummarizing = true;
    });

    try {
      final summarized = await _openAIService.summarizeText(extractedText);
      if (!mounted) return;
      setState(() {
        summarizedText = summarized;
        isSummarizing = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isSummarizing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Summarization failed: $e')),
      );
    }
  }

  void _navigateToScanDocumentScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.scanDocument,
      (route) => false,
    );
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
          _buildSummaryTab(),
          _buildTranslationTab(),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 120,
        child: FloatingActionButton.extended(
          onPressed: _navigateToScanDocumentScreen,
          icon: const Icon(Icons.check),
          label: const Text('Done'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildSummaryTab() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Document Summary',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  if (isSummarizing)
                    const Center(child: CircularProgressIndicator())
                  else
                    Expanded(
                      child: Text(
                        summarizedText.isEmpty ? 'Summarizing...' : summarizedText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationTab() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'English Translation',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  if (isTranslating)
                    const Center(child: CircularProgressIndicator())
                  else
                    Expanded(
                      child: Text(
                        translatedText.isEmpty ? 'Tap to translate' : translatedText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}