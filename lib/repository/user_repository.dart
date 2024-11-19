import 'dart:developer';

import 'package:chat_app/common/config/firebase_api.dart';
import 'package:chat_app/database/models/user.dart';
import 'package:chat_app/database/services/service.dart';
import 'package:chat_app/common/values/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  Future addFriend(String id) async {
    try {
      Future.wait([
        FirebaseApi.addValueToArrayField(
          'users',
          id,
          'listFriends',
          SharedPreferencesService().getString(ID),
        ),
        FirebaseApi.addValueToArrayField(
          'users',
          SharedPreferencesService().getString(ID),
          'listFriends',
          id,
        )
      ]);
    } catch (e) {
      log('Error adding friend: $e');
    }
    return null;
  }

  Future addUser(String email, String name) async {
    // Add user to database
    try {
      final response = await FirebaseApi.addDocument('users', {
        'email': email,
        'name': name,
        "phoneNumber": "",
        "dateOfBirth": "",
        "listFriends": [],
        "fcmtoken": "",
      });
      return User.fromFirestore(response);
    } catch (e) {
      log('Error adding user: $e');
    }
    return null;
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      final response =
          await FirebaseApi.getQuerySnapshot('users', 'email', email);
      if (response.docs.isNotEmpty) {
        return User.fromFirestore(response.docs.first);
      }
    } catch (e) {
      log('Error getting user by email: $e');
    }
    return null;
  }

  Future updateUser(
      String? name, String? phoneNumber, Timestamp? dateOfBirth) async {
    try {
      final response = await FirebaseApi.updateDocument(
          'users', SharedPreferencesService().getString(ID), {
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

  Future<List<User>> getAllUsers() async {
    try {
      final response = await FirebaseApi.getAllDocuments('users');
      return response.map((doc) => User.fromFirestore(doc)).toList();
    } catch (e) {
      log('Error getting all users: $e');
    }
    return [];
  }

  Future<List<User>> getAllFriends() async {
    List<User> friends = [];
    try {
      for (String id in SharedPreferencesService().getList(LIST_FRIENDS)) {
        final response = await FirebaseApi.getDocumentSnapshotById('users', id);
        friends.add(User.fromFirestore(response));
      }
    } catch (e) {
      log('Error getting friends: $e');
    }
    return friends;
  }
}
