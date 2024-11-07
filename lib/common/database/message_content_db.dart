import 'package:sqflite/sqflite.dart';
import 'package:chat_app/common/database/database_service.dart';
import '../models/message_content.dart';

class MessageContentDb {
  final String tableName = 'messageContents';

  Future createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName(
        id TEXT NOT NULL PRIMARY KEY,
        uid TEXT,
        messageId TEXT,
        content TEXT,
        type TEXT,
        createdAt TEXT NOT NULL,
        ForeignKey(uid) REFERENCES users(id),
        ForeignKey(messageId) REFERENCES messages(id)
      )
    ''');
  }

  Future<void> insertMessageContent(MessageContent messageContent, String messageId) async {
    final database = await DatabaseService().db;
    await database.insert(
      tableName,
      {...messageContent.toJson(), 'messageId': messageId, 'createdAt': messageContent.createdAt.toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future updateMessageContent(MessageContent messageContent) async {
    final database = await DatabaseService().db;
    await database.update(
      tableName,
      messageContent.toJson(),
      where: 'id = ?',
      whereArgs: [messageContent.id],
    );
  }

  Future deleteMessageContent(String id) async {
    final database = await DatabaseService().db;
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<MessageContent>> getAllMessageContents() async {
    final database = await DatabaseService().db;
    final response = await database.query(tableName);
    return response.map((e) => MessageContent.fromMap(e)).toList();
  }

  Future<void> deleteAllMessageContents() async {
    final database = await DatabaseService().db;
    await database.delete(tableName);
  }
}