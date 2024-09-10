import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    // If database doesn't exist, create one.
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    // Get the database path
    String path = join(await getDatabasesPath(), 'my_database.db');

    // Open the database
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Create the tables in the database
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT)",
        );
      },
    );
  }

  Future<void> insertEmail(String email) async {
    final db = await database;
    await db.insert(
      'users',
      {'email': email},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (kDebugMode) {
      print("bkjbl");
    }
  }

  Future<String?> getEmail() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    if (maps.isNotEmpty) {
      return maps.last['email'];
    }
    return null;
  }
}
