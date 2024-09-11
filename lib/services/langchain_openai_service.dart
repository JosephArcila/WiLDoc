import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import '../services/firestore_service.dart';

class AIResponse {
  final String text;
  final String prompt;

  AIResponse({required this.text, required this.prompt});
}

class OpenAIService {
  late Future<OpenAI> _openAI;

  final FirestoreService firestoreService = FirestoreService();

  OpenAIService() {
    _openAI = _initializeOpenAI();
  }

  Future<OpenAI> _initializeOpenAI() async {
    var storeResult = await firestoreService.getOpenAIKey();
    return OpenAI(apiKey: storeResult);
  }

  Future<AIResponse> explainText(String text, String preferredLanguage) async {
    try {
      final promptTemplate = PromptTemplate.fromTemplate(
        'Provide a comprehensive explanation of the following text in {language}, leaving no detail out. Explain as if you\'re talking to someone who is not familiar with the subject, but needs to understand all aspects of the document:\n\n{text}'
      );

      final prompt = promptTemplate.format({'language': preferredLanguage, 'text': text});

      OpenAI openAIInstance = await _openAI;
      final chain = LLMChain(
        prompt: promptTemplate,
        llm: openAIInstance,
      );

      final response = await chain.run({
        'language': preferredLanguage,
        'text': text,
      });

      return AIResponse(text: response.trim(), prompt: prompt);
    } catch (e) {
      throw Exception('Explanation failed: $e');
    }
  }

  Future<AIResponse> summarizeText(String text, String preferredLanguage) async {
    try {
      final promptTemplate = PromptTemplate.fromTemplate(
        'Provide a brief summary of the following text in {language}, focusing on what the document is about and its main points. Keep it concise, like a short introduction:\n\n{text}'
      );

      final prompt = promptTemplate.format({'language': preferredLanguage, 'text': text});

      OpenAI openAIInstance = await _openAI;
      final chain = LLMChain(
        prompt: promptTemplate,
        llm: openAIInstance,
      );

      final response = await chain.run({
        'language': preferredLanguage,
        'text': text,
      });

      return AIResponse(text: response.trim(), prompt: prompt);
    } catch (e) {
      throw Exception('Summarization failed: $e');
    }
  }
}