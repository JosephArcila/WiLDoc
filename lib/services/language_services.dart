import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'language_service/langchain_openai_service.dart';

class LanguageService {
  final OpenAiInitializer openAiInitializer = OpenAiInitializer();
  OpenAI? openAIInstance;

  LanguageService._(); // make the constructor private

  static Future<LanguageService> create() async {
    var instance = LanguageService._();
    instance.openAIInstance = await instance.openAiInitializer.openAIInstance;
    return instance;
  }

  Future<String> explainText(String text, String languageKey) async {
    try {
      final prompt = PromptTemplate.fromTemplate(
          'Translate the following text $text into $languageKey...'
      );
      final chain = LLMChain(
        prompt: prompt,
        llm: openAIInstance!,
      );
      final response = await chain.run({
        'text': text,
      });
      return response.trim();
    } catch (e) {
      throw Exception('Explanation failed: $e');
    }
  }

  Future<String> summarizeText(String text, String languageKey) async {
    try {
      final prompt =PromptTemplate.fromTemplate(
          'Translate the following text $text into $languageKey...'
      );
      final chain = LLMChain(
        prompt: prompt,
        llm: openAIInstance!,
      );
      final response = await chain.run({
        'text': text,
      });
      return response.trim();
    } catch (e) {
      throw Exception('Summarization failed: $e');
    }
  }

  Future<String> explainAndTranslateText(String text, String languageKey) async {
    String explainedText = await explainText(text, languageKey);
    return explainedText;
  }

  Future<String> summarizeAndTranslateText(String text, String languageKey) async {
    String summarizedText = await summarizeText(text, languageKey);
    return summarizedText;
  }
}