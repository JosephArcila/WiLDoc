import 'package:flutter/material.dart';
import 'package:wil_doc/utils/temp_data.dart';
import 'package:wil_doc/services/langchain_openai_service.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentSummaryScreen extends StatefulWidget {
  const DocumentSummaryScreen({super.key});

  @override
  DocumentSummaryScreenState createState() => DocumentSummaryScreenState();
}

class DocumentSummaryScreenState extends State<DocumentSummaryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String extractedText = '';
  String explainedText = '';
  String summarizedText = '';
  bool isExplaining = false;
  bool isSummarizing = false;
  late OpenAIService _openAIService;

  final String _feedbackFormUrl = 'https://forms.gle/N3TqDD3Sqno9TPMYA';

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

  Future<void> _explainText() async {
    if (!mounted) return;
    setState(() {
      isExplaining = true;
    });

    try {
      final explained = await _openAIService.explainText(extractedText);
      if (!mounted) return;
      setState(() {
        explainedText = explained;
        isExplaining = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isExplaining = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Explanation failed: $e')),
        );
      }
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Summarization failed: $e')),
        );
      }
    }
  }

  void _navigateToScanDocumentScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.scanDocument,
      (route) => false,
    );
  }

  void _navigateToDocumentPreviewScreen() {
    Navigator.pop(context);
  }

  Future<void> _openFeedbackForm() async {
    final Uri url = Uri.parse(_feedbackFormUrl);
    if (!await launchUrl(url)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open feedback form. Please try again later.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Document Scan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _navigateToDocumentPreviewScreen,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Summary',
              icon: Icon(_tabController.index == 0 ? Icons.summarize : Icons.summarize_outlined),
            ),
            Tab(
              text: 'Explanation',
              icon: Icon(_tabController.index == 1 ? Icons.description : Icons.description_outlined),
            ),
          ],
          onTap: (index) {
            setState(() {});
            if (index == 1 && explainedText.isEmpty && !isExplaining) {
              _explainText();
            }
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSummaryTab(),
          _buildExplanationTab(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            onPressed: _openFeedbackForm,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            tooltip: 'Provide Feedback',
            child: const Icon(Icons.feedback_outlined),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 120,
            child: FloatingActionButton.extended(
              onPressed: _navigateToScanDocumentScreen,
              icon: const Icon(Icons.check),
              label: const Text('Done'),
            ),
          ),
        ],
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

  Widget _buildExplanationTab() {
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
                    'Document Explanation',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  if (isExplaining)
                    const Center(child: CircularProgressIndicator())
                  else
                    Expanded(
                      child: Text(
                        explainedText.isEmpty ? 'Tap to explain' : explainedText,
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