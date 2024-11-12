import 'dart:developer';

import 'package:chat_app/common/config/firebase_api.dart';
import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/database/models/request.dart';
import 'package:chat_app/database/services/service.dart';

class RequestRepository {
  Future createRequest(Request request) async {
    try {
      await FirebaseApi.addDocument('requests', request.toFirestore());
    } catch (e) {
      log('Error creating request: $e');
    }
  }

  Future deleteRequest(String id) async {
    try {
      await FirebaseApi.deleteDocument('requests', id);
    } catch (e) {
      log('Error deleting request: $e');
    }
  }

  Future<List<Request>> getRequest(String field) async {
    try {
      final response = await FirebaseApi.getDocumentsByValue('requests', field, SharedPreferencesService().getString(ID));
      return response.isNotEmpty ? response.map((e)=> Request.fromFirestore(e)).toList() : [];
    } catch (e) {
      log('Error getting request: $e');
    }
    return [];
  }
}
