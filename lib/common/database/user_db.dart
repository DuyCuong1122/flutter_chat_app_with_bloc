import 'package:chat_app/common/database/database_service.dart';
import 'package:sqflite/sqflite.dart';

import '../models/model.dart';

class UserDb {
  final tableName = 'users';

  Future createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName(
        id TEXT NOT NULL PRIMARY KEY,
        name TEXT,
        email TEXT NOT NULL,
        phoneNumber TEXT,
        dateOfBirth TEXT,
        listFriends TEXT,
      )
    ''');
  }

  Future<void> insertUser(User userData) async {
    final database = await DatabaseService().db;
    await database.insert(
      tableName,
      userData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUser(String id) async {
    final database = await DatabaseService().db;
    final response = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return response.isNotEmpty ? User.fromMap(response.first) : null;
  }

  Future updateUser(User userData) async {
    final database = await DatabaseService().db;
    await database.update(
      tableName,
      userData.toFirestore(),
      where: 'id = ?',
      whereArgs: [userData.id],
    );
  }

  Future deleteUser(String id) async {
    final database = await DatabaseService().db;
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<User>> getAllUsers() async {
    final database = await DatabaseService().db;
    final response = await database.query(tableName);
    return response.map((e) => User.fromMap(e)).toList();
  }

  Future<void> deleteAllUsers() async {
    final database = await DatabaseService().db;
    await database.delete(tableName);
  }
}
