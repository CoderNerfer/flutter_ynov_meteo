import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLRequest {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE cities(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        city TEXT,
        latitude TEXT,
        longitude TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'ynov.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new city
  static Future<int> createCity(
      String city, String latitude, String longitude) async {
    final db = await SQLRequest.db();

    final data = {'city': city, 'latitude': latitude, 'longitude': longitude};
    final id = await db.insert('cities', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Fetch all cities
  static Future<List<Map>> getCities() async {
    final db = await SQLRequest.db();
    return db.query('cities', orderBy: "id") as List<Map>;
  }

  // Read a single city by id
  static Future<List<Map<String, dynamic>>> getCity(int id) async {
    final db = await SQLRequest.db();
    return db.query('cities', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update a city by id
  static Future<int> updateCity(
      int id, String city, String latitude, String longitude) async {
    final db = await SQLRequest.db();

    final data = {
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('cities', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteCity(int id) async {
    final db = await SQLRequest.db();
    try {
      await db.delete("cities", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting a city: $err");
    }
  }
}
