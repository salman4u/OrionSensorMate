import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/Hub.dart';

class HubDatabase {
  static final HubDatabase instance = HubDatabase._init();
  static Database? _database;

  HubDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hub.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE hub (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      manNumber TEXT NOT NULL,
      hubName TEXT NOT NULL,
      description TEXT NOT NULL,
      did TEXT,
      hubType TEXT NOT NULL
    )
  ''');
  }


  // Insert
  Future<int> insertHub(Hub hub) async {
    final db = await instance.database;
    return await db.insert('hub', hub.toMap());
  }

  // Get all
  Future<List<Hub>> getHubs() async {
    final db = await instance.database;
    final result = await db.query('hub');
    return result.map((json) => Hub.fromMap(json)).toList();
  }

  // Update
  Future<int> updateHub(Hub hub) async {
    final db = await instance.database;
    return await db.update(
      'hub',
      hub.toMap(),
      where: 'id = ?',
      whereArgs: [hub.id],
    );
  }

  // Delete
  Future<int> deleteHub(int id) async {
    final db = await instance.database;
    return await db.delete(
      'hub',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
