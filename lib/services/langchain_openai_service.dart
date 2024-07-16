import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';

class OpenAIService {
  final OpenAI _openAI;

  OpenAIService() 
  : _openAI = OpenAI(apiKey: 'sk-None-eKLfQgXH4Iw3Ry5ZUa0zT3BlbkFJoAu9tOSoDVWOqqXHT0ET');

  Future<String> explainText(String text) async {
    try {
      final prompt = PromptTemplate.fromTemplate(
        'Provide a comprehensive explanation of the following text in simple English, leaving no detail out. Explain as if you\'re talking to someone who is not familiar with the subject, but needs to understand all aspects of the document:\n\n{text}'
      );
      
      final chain = LLMChain(
        prompt: prompt,
        llm: _openAI,
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
      
      final chain = LLMChain(
        prompt: prompt,
        llm: _openAI,
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