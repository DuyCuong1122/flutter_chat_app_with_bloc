import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();
  static SharedPreferences? _preferences;

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
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

  
}
