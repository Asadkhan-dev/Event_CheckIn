import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:event_manager/data/model/event_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'events.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE events (
      id TEXT NOT NULL PRIMARY KEY,
      event_name TEXT NOT NULL,
      event_date TEXT NOT NULL,
      event_time TEXT NOT NULL,
      img TEXT NOT NULL,
      timestamp TEXT NOT NULL
    )
  ''');
  }
  Future<int> insertEvent(EventModel event) async {
    Database db = await database;
    final existingEvent = await db.query('events', where: 'id = ?', whereArgs: [event.id]);

    if (existingEvent.isNotEmpty) {
      // Update the existing event
      return await db.update('events', event.toMap(), where: 'id = ?', whereArgs: [event.id]);
    } else {
      print(await db.insert('events', event.toMap(), conflictAlgorithm: ConflictAlgorithm.replace)
      );
      // Insert a new event
      return await db.insert('events', event.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> deleteAllEvents() async {
    Database db = await database;
    await db.delete('events');
  }
  Future<List<EventModel>> getAllEvents() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('events');
    return maps.map((map) {
      return EventModel.fromMap(map);
    }).toList();
  }

  Future<int> updateEvent(EventModel event) async {
    Database db = await database;
    return await db.update('events', event.toMap(),
        where: 'id = ?', whereArgs: [event.id]);
  }

  Future<int> deleteEvent(int id) async {
    Database db = await database;
    return await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }
}
