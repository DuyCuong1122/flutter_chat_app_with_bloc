import 'package:chat_app/common/database/chat_app_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? database;

  Future<Database> get db async {
    if (database != null) {
      return database!;
    }
    database = await initialize();
    return database!;
  }

  Future<String> get fullPath async {
    const databaseName = 'chatApp.db';
    final path = await getDatabasesPath();
    return join(path, databaseName);
  }

  Future<Database> initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      singleInstance: true,
    );
    return database;
  }

  Future<void> _onCreate(Database db, int version) async {
    await UserDb().createTable(db);
    await MessageDb().createTable(db);
    await RequestDb().createTable(db);
    await MessageContentDb().createTable(db);
  }
}
