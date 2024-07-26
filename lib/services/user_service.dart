import 'package:flutter/foundation.dart';
import 'package:wil_doc/services/firestore_service.dart';
import '../models/user.dart';


class UserService {
  final FirestoreService _firestoreService;

  UserService(this._firestoreService);

  Future<String?> getUserPreferredLanguage(String userId) async {
    try {
      User? user = await _firestoreService.getUser(userId);
      return user?.preferredLanguage;
    } catch(e) {
      if (kDebugMode) {
        print('Failed to get user or user language: $e');
      }
      return null;
    }
  }
}