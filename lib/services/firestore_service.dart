import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUser(User user) async {
    try {
      if (kDebugMode) {
        print("Attempting to save user: ${user.userId} with data: ${user.toMap()}");
      }
      await _firestore.collection('users').doc(user.userId).set(user.toMap());
      if (kDebugMode) {
        print("User saved successfully: ${user.userId}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error saving user: $e");
      }
      if (e is FirebaseException) {
        if (kDebugMode) {
          print("FirebaseException: ${e.message}");
        }
      }
      rethrow;
    }
  }

  Future<User?> getUser(String userId) async {
    try {
      if (kDebugMode) {
        print("Attempting to get user: $userId");
      }
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        if (kDebugMode) {
          print("User found: ${doc.id}");
        }
        return User.fromMap(doc.data() as Map<String, dynamic>);
      }
      if (kDebugMode) {
        print("User not found: $userId");
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error getting user: $e");
      }
      return null;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      if (kDebugMode) {
        print("Attempting to update user: ${user.userId} with data: ${user.toMap()}");
      }
      await _firestore.collection('users').doc(user.userId).update(user.toMap());
      if (kDebugMode) {
        print("User updated successfully: ${user.userId}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user: $e");
      }
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      if (kDebugMode) {
        print("Attempting to delete user: $userId");
      }
      await _firestore.collection('users').doc(userId).delete();
      if (kDebugMode) {
        print("User deleted successfully: $userId");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting user: $e");
      }
      rethrow;
    }
  }
}
