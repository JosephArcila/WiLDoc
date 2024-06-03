import 'package:flutter/foundation.dart';
import 'package:wil_doc/models/user.dart';
import 'package:wil_doc/services/firestore_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final FirestoreService _firestoreService = FirestoreService();

  User? get user => _user;

  Future<void> loadUser(String userId) async {
    try {
      if (kDebugMode) {
        print("Attempting to load user: $userId");
      }
      _user = await _firestoreService.getUser(userId);
      notifyListeners();
      if (kDebugMode) {
        print("User loaded: ${_user?.toMap()}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading user: $e");
      }
    }
  }

  Future<void> saveUser(User user) async {
    try {
      if (kDebugMode) {
        print("Attempting to save user in UserProvider: ${user.toMap()}");
      }
      await _firestoreService.saveUser(user);
      _user = user;
      notifyListeners();
      if (kDebugMode) {
        print("User saved in UserProvider: ${_user?.toMap()}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error saving user in UserProvider: $e");
      }
    }
  }

  Future<void> updateUser(User user) async {
    try {
      if (kDebugMode) {
        print("Attempting to update user in UserProvider: ${user.toMap()}");
      }
      await _firestoreService.updateUser(user);
      _user = user;
      notifyListeners();
      if (kDebugMode) {
        print("User updated in UserProvider: ${_user?.toMap()}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user in UserProvider: $e");
      }
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      if (kDebugMode) {
        print("Attempting to delete user in UserProvider: $userId");
      }
      await _firestoreService.deleteUser(userId);
      _user = null;
      notifyListeners();
      if (kDebugMode) {
        print("User deleted in UserProvider: $userId");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting user in UserProvider: $e");
      }
    }
  }
}
