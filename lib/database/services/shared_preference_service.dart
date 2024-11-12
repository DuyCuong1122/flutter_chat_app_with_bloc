import 'dart:developer';

import 'package:chat_app/common/values/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();
  static SharedPreferences? _preferences;

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future setUserValue(String name, String phone, Timestamp? birthday,
      {String? id, String? email, List<String>? listFriends}) async {
    await SharedPreferencesService().setString(NAME, name);
    if (email != null) await SharedPreferencesService().setString(EMAIL, email);
    await SharedPreferencesService().setString(PHONE_NUMBER, phone);
    await SharedPreferencesService().setString(
        DATE_OF_BIRTH,
        birthday != null
            ? '${birthday.toDate().day}/${birthday.toDate().month}/${birthday.toDate().year}'
            : '');
    if (id != null) await SharedPreferencesService().setString(ID, id);
    if (listFriends != null) {
      await SharedPreferencesService().setList(LIST_FRIENDS, listFriends);
    }
    log('Set user value: $name, $phone, ${SharedPreferencesService().getString(DATE_OF_BIRTH)}');
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences!.setBool(key, value);
  }

  Future<bool> setList(String key, List<String> value) async {
    return await _preferences!.setStringList(key, value);
  }

  String getString(String key) {
    return _preferences!.getString(key) ?? '';
  }

  bool getBool(String key) {
    return _preferences!.getBool(key) ?? false;
  }

  List<String> getList(String key) {
    return _preferences!.getStringList(key) ?? [];
  }

  Future<bool> remove(String key) async {
    return await _preferences!.remove(key);
  }

  Future clear() async {
    return await _preferences!.clear();
  }
}
