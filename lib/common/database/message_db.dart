import 'package:sqflite/sqflite.dart';
import 'package:chat_app/common/database/database_service.dart';
import '../models/message.dart';

class MessageDb {
  final String tableName = 'messages';

  Future createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName(
        id TEXT NOT NULL PRIMARY KEY,
        fromUId TEXT,
        toUId TEXT,
        lastMessage TEXT,
        lastTime TEXT,
        isRead INTEGER,
        fromName TEXT,
        toName TEXT,
        unreadCount INTEGER
        ForeignKey(fromUId) REFERENCES users(id),
        ForeignKey(toUId) REFERENCES users(id)
      )
    ''');
  }

  Future<void> insertMessage(Message message) async {
    final database = await DatabaseService().db;
    await database.insert(
      tableName,
      {...message.toFirestore(), 'lastTime': message.lastTime.toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Message?> getMessage(String id) async {
    final database = await DatabaseService().db;
    final response = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return response.isNotEmpty ? Message.fromMap(response.first) : null;
  }

  Future updateMessage(Message message) async {
    final database = await DatabaseService().db;
    await database.update(
      tableName,
      message.toFirestore(),
      where: 'id = ?',
      whereArgs: [message.id],
    );
  }

  Future deleteMessage(String id) async {
    final database = await DatabaseService().db;
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Message>> getAllMessages() async {
    final database = await DatabaseService().db;
    final response = await database.query(tableName);
    return response.map((e) => Message.fromMap(e)).toList();
  }

  Future<void> deleteAllMessages() async {
    final database = await DatabaseService().db;
    await database.delete(tableName);
  }
}