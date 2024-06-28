import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  final OpenAI _openAI;

  OpenAIService({String? apiKey}) 
  : _openAI = OpenAI(apiKey: apiKey ?? dotenv.env['OPENAI_API_KEY'] ?? '');

  Future<String> translateText(String text, String targetLanguage) async {
    try {
      final prompt = PromptTemplate.fromTemplate(
        'Translate the following text to {language}:\n\n{text}'
      );
      
      final chain = LLMChain(
        prompt: prompt,
        llm: _openAI,
      );

      final response = await chain.run({
        'language': targetLanguage,
        'text': text,
      });

      return response.trim();
    } catch (e) {
      throw Exception('Translation failed: $e');
    }
  }
}