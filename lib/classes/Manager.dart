import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tools_manager/classes/Tool.dart';

class Manager {
  static final Manager _instance = Manager._internal();
  factory Manager() => _instance;
  Manager._internal();

  final Map<String, Tool> tools = {};
  Database? _db;

  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tools_manager.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE tools (
            id TEXT PRIMARY KEY,
            name TEXT,
            type TEXT,
            status TEXT,
            userID TEXT
          )
        ''');
      },
    );

    await _loadToolsFromDb();
  }

  Map<String, Tool> getTools() {
    return tools;
  }

  Future<void> addTool({
    required String name,
    required String category,
    required String status,
  }) async {
    if (_db == null) {
      throw Exception('Database not initialized. Call initDatabase() first.');
    }

    final tool = Tool(name: name, type: category, status: status);

    await _db!.insert(
      'tools',
      tool.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    tools[tool.id] = tool;
    print('Tool added to SQLite successfully');
  }

  Future<void> _loadToolsFromDb() async {
    if (_db == null) return;

    final List<Map<String, dynamic>> records = await _db!.query('tools');
    for (final record in records) {
      final tool = Tool.fromMap(record);
      tools[tool.id] = tool;
    }
  }

  Future<void> loadTools() async {
    tools.clear();
    await _loadToolsFromDb();
    print('Tools loaded from SQLite.');
  }
}
