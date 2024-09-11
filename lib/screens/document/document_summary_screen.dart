import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wil_doc/utils/temp_data.dart';
import 'package:wil_doc/services/langchain_openai_service.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:universal_html/html.dart' as html;
import 'package:wil_doc/providers/user_provider.dart';

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
  String explainPrompt = '';
  String summarizePrompt = '';
  bool isExplaining = false;
  bool isSummarizing = false;
  late OpenAIService _openAIService;
  String? userPreferredLanguage;

  final String _feedbackFormUrl = 'https://forms.gle/ALJHjrvNu5aCnRsA7';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    extractedText = TempData.extractedText ?? '';
    if (kDebugMode) {
      print('Extracted text in DocumentSummaryScreen: $extractedText');
      if (extractedText.isEmpty) {
        print('Warning: No extracted text available');
      }
    }
    _openAIService = OpenAIService();
    _getUserPreferredLanguage();
  }

  void _getUserPreferredLanguage() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userPreferredLanguage = userProvider.user?.preferredLanguage ?? 'English';
    if (kDebugMode) {
      print('User preferred language: $userPreferredLanguage');
    }
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
      final result = await _openAIService.explainText(extractedText, userPreferredLanguage ?? 'English');
      if (!mounted) return;
      setState(() {
        explainedText = result.text;
        explainPrompt = result.prompt;
        isExplaining = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isExplaining = false;
        explainedText = 'Explanation failed: $e';
      });
      if (kDebugMode) {
        print('Error during explanation: $e');
      }
    }
  }

  Future<void> _summarizeText() async {
    if (!mounted) return;
    setState(() {
      isSummarizing = true;
    });

    try {
      final result = await _openAIService.summarizeText(extractedText, userPreferredLanguage ?? 'English');
      if (!mounted) return;
      setState(() {
        summarizedText = result.text;
        summarizePrompt = result.prompt;
        isSummarizing = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isSummarizing = false;
        summarizedText = 'Summarization failed: $e';
      });
      if (kDebugMode) {
        print('Error during summarization: $e');
      }
    }
  }

  void _navigateToScanDocumentScreen() {
    TempData.extractedText = null;
    TempData.imagePath = null;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.scanDocument,
      (route) => false,
    );
  }

  Future<void> _openFeedbackForm() async {
    if (kIsWeb) {
      html.window.open(_feedbackFormUrl, '_blank');
    } else {
      final Uri url = Uri.parse(_feedbackFormUrl);
      if (await url_launcher.canLaunchUrl(url)) {
        await url_launcher.launchUrl(url, mode: url_launcher.LaunchMode.externalApplication);
      } else {
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Document Scan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _navigateToScanDocumentScreen,
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
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent(
                  title: 'Document Summary',
                  isLoading: isSummarizing,
                  prompt: summarizePrompt,
                  generatedText: summarizedText,
                  loadingText: 'Summarizing...',
                ),
                _buildTabContent(
                  title: 'Document Explanation',
                  isLoading: isExplaining,
                  prompt: explainPrompt,
                  generatedText: explainedText,
                  loadingText: 'Tap to explain',
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16),
        child: Column(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildTabContent({
    required String title,
    required bool isLoading,
    required String prompt,
    required String generatedText,
    required String loadingText,
  }) {
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
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  if (kDebugMode) ...[
                    Text(
                      'Prompt (Debug):',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      prompt.isEmpty ? 'Prompt not available' : prompt,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    Expanded(
                      child: Text(
                        generatedText.isEmpty ? loadingText : generatedText,
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