import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:event_manager/data/model/event_model.dart';

class CheckInDatabaseHelper {
  static final CheckInDatabaseHelper _instance = CheckInDatabaseHelper._internal();

  factory CheckInDatabaseHelper() => _instance;

  CheckInDatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'check_in.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Check_in (
      id TEXT NOT NULL PRIMARY KEY,
      event_name TEXT NOT NULL,
      event_date TEXT NOT NULL,
      event_time TEXT NOT NULL,
      img TEXT NOT NULL,
      timestamp TEXT NOT NULL
    )
  ''');
  }

  Future<int> insertCheckIn(EventModel checkIn) async {
    Database db = await database;
    final existingCheckIn = await db.query('check_in', where: 'id = ?', whereArgs: [checkIn.id]);

    if (existingCheckIn.isNotEmpty) {
      // Update the existing check-in
      return await db.update('check_in', checkIn.toMap(), where: 'id = ?', whereArgs: [checkIn.id]);
    } else {
      // Insert a new check-in
      return await db.insert('check_in', checkIn.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> deleteAllCheckIns() async {
    Database db = await database;
    await db.delete('check_in');
  }

  Future<List<EventModel>> getAllCheckIns() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('check_in');
    return maps.map((map) {
      return EventModel.fromMap(map);
    }).toList();
  }

  Future<int> updateCheckIn(EventModel checkIn) async {
    Database db = await database;
    return await db.update('check_in', checkIn.toMap(),
        where: 'id = ?', whereArgs: [checkIn.id]);
  }

  Future<int> deleteCheckIn(String id) async {
    Database db = await database;
    return await db.delete('check_in', where: 'id = ?', whereArgs: [id]);
  }
}