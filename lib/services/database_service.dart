import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:abacus/model/arithmetic_puzzle/puzzle_session.dart';

class DatabaseService {
  DatabaseService._constructor();
  static final DatabaseService dataServiceInstance = DatabaseService._constructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'puzzle_sessions.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE puzzle_sessions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            dateTime DATETIME NOT NULL,
            score INTEGER NOT NULL,
            total INTEGER NOT NULL,
            mode TEXT NOT NULL,
            totalTimeMs INTEGER NOT NULL
          )
        ''');

        // Single row settings table
        await db.execute('''
          CREATE TABLE settings(
            id INTEGER PRIMARY KEY CHECK (id = 1),
            difficulty TEXT NOT NULL DEFAULT 'Medium'
          )
        ''');

        // Setting the one and only row with defaults
        await db.insert('settings', {'id': 1, 'difficulty': 'Medium'});

      },
    );
  }

  Future<int> insertPuzzleSession(PuzzleSession session) async {
    final db = await database;
    return await db.insert('puzzle_sessions', session.toMap());
  }

  Future<List<PuzzleSession>> getPuzzleSession() async {
    final db = await database;
    final maps = await db.query('puzzle_sessions', orderBy: 'dateTime DESC');
    return maps.map((map) => PuzzleSession.fromMap(map)).toList();
  }

  Future<int> updatePuzzleSession(PuzzleSession session) async {
    final db = await database;
    return await db.update(
      'puzzle_sessions',
      session.toMap(),
      where: 'id = ?',
      whereArgs: [session.id],
    );
  }

  Future<int> deletePuzzleSession(int id) async {
    final db = await database;
    return await db.delete('puzzle_sessions', where: 'id = ?', whereArgs:[id]);
  }

  // Difficulty Settings Methods

  Future<String> getDifficulty() async {
    final db = await database;
    final rows = await db.query('settings', where: 'id = 1');
    return rows.isEmpty ? 'Medium' : rows.first['difficulty'] as String;
  }

  Future<int> setDifficulty(String value) async {
    final db = await database;
    return await db.update(
      'settings',
      {'difficulty': value},
      where: 'id = 1',
    );
  }

}