import 'dart:developer';

import 'package:chat_app/common/config/firebase_api.dart';

class UserRepository {
  Future addUser(String email, String name) async {
    // Add user to database
    try {
      final response = await FirebaseApi.addDocument('users', {
        'email': email,
        'name': name,
        "phoneNumber": "",
        "dateOfBirth": "",
      });
      return response;
    } catch (e) {
      log('Error adding user: $e');
    }
    return null;
  }

  Future getUserByEmail(String email) async {
    try {
      final response = await FirebaseApi.getQuerySnapshot('users', 'email', email);
      if (response.docs.isNotEmpty) {
        return response.docs.first.data();
      }
    } catch (e) {
      log('Error getting user by email: $e');
    }
    return null;
  }

  Future updateUser (String? name, String? phoneNumber, String? dateOfBirth)async{
    try {
      final response = await FirebaseApi.updateDocument('users', 'id', {
        'name': name,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
      });
      return response;
    } catch (e) {
      log('Error updating user: $e');
    }
    return null;
  }
}
