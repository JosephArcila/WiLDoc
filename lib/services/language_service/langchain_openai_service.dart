import 'package:langchain_openai/langchain_openai.dart';

import '../firestore_service.dart';

class OpenAiInitializer {
  final FirestoreService firestoreService = FirestoreService();
  late Future<OpenAI> _openAI;

  OpenAiInitializer() {
    _openAI = _initializeOpenAI();
  }

  Future<OpenAI> _initializeOpenAI() async {
    var storeResult = await firestoreService.getOpenAIKey();
    return OpenAI(apiKey: storeResult);
  }

  Future<OpenAI> get openAIInstance => _openAI;
}
