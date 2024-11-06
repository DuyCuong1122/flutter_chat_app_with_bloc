import 'package:sqflite/sqflite.dart';
import 'package:chat_app/common/database/database_service.dart';
import '../models/request.dart';

class RequestDb {
  final String tableName = 'requests';

  Future createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName(
        id TEXT NOT NULL PRIMARY KEY,
        fromUId TEXT,
        toUId TEXT,
        fromName TEXT,
        toName TEXT,
        createdAt TEXT,
        FOREIGN KEY(fromUId) REFERENCES users(id),
        FOREIGN KEY(toUId) REFERENCES users(id)
      )
    ''');
  }

  Future<void> insertRequest(Request request) async {
    final database = await DatabaseService().db;
    await database.insert(
      tableName,
      request.toFirestore(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Request?> getRequest(String id) async {
    final database = await DatabaseService().db;
    final response = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return response.isNotEmpty ? Request.fromMap(response.first) : null;
  }

  Future updateRequest(Request request) async {
    final database = await DatabaseService().db;
    await database.update(
      tableName,
      request.toFirestore(),
      where: 'id = ?',
      whereArgs: [request.id],
    );
  }

  Future deleteRequest(String id) async {
    final database = await DatabaseService().db;
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Request>> getAllRequests() async {
    final database = await DatabaseService().db;
    final response = await database.query(tableName);
    return response.map((e) => Request.fromMap(e)).toList();
  }

  Future<void> deleteAllRequests() async {
    final database = await DatabaseService().db;
    await database.delete(tableName);
  }
}