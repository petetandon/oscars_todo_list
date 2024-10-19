import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/task.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  static final String _tasksTableName = "tasks";
  static final String _tasksIdColumnName = "id";
  static final String _tasksContentColumnName = "content";
  static final String _tasksStatusColumnName = "status";

  DatabaseService._constructor();

  Future<Database> get database async {
    _db ??= await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_dv.db");
    final database =
        await openDatabase(databasePath, version: 1, onCreate: (db, version) {
      db.execute('''
      CREATE TABLE $_tasksTableName (
        $_tasksIdColumnName INTEGER PRIMARY KEY,
        $_tasksContentColumnName TEXT NOT NULL,
        $_tasksStatusColumnName INTEGER DEFAULT 0
      )
      ''');
    });
    return database;
  }

  Future<bool> addTask(
    String content,
  ) async {
    try {
      final db = await database;
      await db.insert(_tasksTableName, {
        _tasksContentColumnName: content,
        _tasksStatusColumnName: 0,
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final data = await db.query(_tasksTableName);
    return data.map((v) => fromMap(v)).toList();
  }

  static Task fromMap(Map<String, Object?> map) {
    int id = map[_tasksIdColumnName] as int;
    int status = map[_tasksStatusColumnName] as int;
    String content = map[_tasksContentColumnName] as String;
    return Task(id: id, status: status, content: content);
  }
}
