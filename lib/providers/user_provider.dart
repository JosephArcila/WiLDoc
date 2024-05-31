import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get user => _user;

  Future<void> loadUser(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        _user = User.fromMap(doc.data() as Map<String, dynamic>);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading user: $e");
      }
    }
  }

  Future<void> saveUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.userId).set(user.toMap());
      _user = user;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error saving user: $e");
      }
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.userId).update(user.toMap());
      _user = user;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user: $e");
      }
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      _user = null;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting user: $e");
      }
    }
  }
}
