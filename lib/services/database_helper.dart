import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:abacus/model/arithmetic_puzzle/puzzle_session.dart';

class DatabaseHelper {
  // Singleton so every part of the app shares one open connection.
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  static const String tableName = 'puzzle_sessions';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'abacus.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            dateTime TEXT NOT NULL,
            score INTEGER NOT NULL,
            total INTEGER NOT NULL,
            totalTimeMs INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // ---- Create ----
  Future<int> insertSession(PuzzleSession session) async {
    final db = await database;
    return db.insert(
      tableName,
      session.toMap()..remove('id'), // let SQLite assign the id
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ---- Read ----
  Future<List<PuzzleSession>> getAllSessions() async {
    final db = await database;
    final maps = await db.query(tableName, orderBy: 'dateTime DESC');
    return maps.map((map) => PuzzleSession.fromMap(map)).toList();
  }

  Future<PuzzleSession?> getSession(int id) async {
    final db = await database;
    final maps = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return PuzzleSession.fromMap(maps.first);
  }

  // ---- Update ----
  Future<int> updateSession(PuzzleSession session) async {
    final db = await database;
    return db.update(
      tableName,
      session.toMap(),
      where: 'id = ?',
      whereArgs: [session.id],
    );
  }

  // ---- Delete ----
  Future<int> deleteSession(int id) async {
    final db = await database;
    return db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllSessions() async {
    final db = await database;
    return db.delete(tableName);
  }
}
