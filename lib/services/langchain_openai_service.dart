import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import '../services/firestore_service.dart';

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

  Future<String> explainText(String text) async {
    try {
      final prompt = PromptTemplate.fromTemplate(
        'Provide a comprehensive explanation of the following text in simple English, leaving no detail out. Explain as if you\'re talking to someone who is not familiar with the subject, but needs to understand all aspects of the document:\n\n{text}'
      );

      OpenAI openAIInstance = await _openAI;
      final chain = LLMChain(
        prompt: prompt,
        llm: openAIInstance,
      );

      final response = await chain.run({
        'text': text,
      });

      return response.trim();
    } catch (e) {
      throw Exception('Explanation failed: $e');
    }
  }

  Future<String> summarizeText(String text) async {
    try {
      final prompt = PromptTemplate.fromTemplate(
        'Provide a brief summary of the following text, focusing on what the document is about and its main points. Keep it concise, like a short introduction:\n\n{text}'
      );

      OpenAI openAIInstance = await _openAI;
      final chain = LLMChain(
        prompt: prompt,
        llm: openAIInstance,
      );

      final response = await chain.run({
        'text': text,
      });

      return response.trim();
    } catch (e) {
      throw Exception('Summarization failed: $e');
    }
  }
}