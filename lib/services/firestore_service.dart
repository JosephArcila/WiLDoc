import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUser(User user) async {
    try {
      print("Attempting to save user: ${user.userId} with data: ${user.toMap()}");
      await _firestore.collection('users').doc(user.userId).set(user.toMap());
      print("User saved successfully: ${user.userId}");
    } catch (e) {
      print("Error saving user: $e");
      if (e is FirebaseException) {
        print("FirebaseException: ${e.message}");
      }
      rethrow;
    }
  }

  Future<User?> getUser(String userId) async {
    try {
      print("Attempting to get user: $userId");
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        print("User found: ${doc.id}");
        return User.fromMap(doc.data() as Map<String, dynamic>);
      }
      print("User not found: $userId");
      return null;
    } catch (e) {
      print("Error getting user: $e");
      return null;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      print("Attempting to update user: ${user.userId} with data: ${user.toMap()}");
      await _firestore.collection('users').doc(user.userId).update(user.toMap());
      print("User updated successfully: ${user.userId}");
    } catch (e) {
      print("Error updating user: $e");
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      print("Attempting to delete user: $userId");
      await _firestore.collection('users').doc(userId).delete();
      print("User deleted successfully: $userId");
    } catch (e) {
      print("Error deleting user: $e");
      rethrow;
    }
  }
}
