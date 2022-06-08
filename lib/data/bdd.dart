import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:ynov_meteo/services/current_service.dart';
import 'package:ynov_meteo/model/weather.dart';

Future<void> createTables(sql.Database database) async {
  await database.execute("""CREATE TABLE cities(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        city TEXT,
        latitude TEXT,
        longitude TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
}

Future<sql.Database> initdb() async {
  return sql.openDatabase(
    'ynov.db',
    version: 1,
    onCreate: (sql.Database database, int version) async {
      await createTables(database);
    },
  );
}

// Create new city
// Future<int> createCity(String city, String latitude, String longitude) async {
Future<int> createCity(String city) async {
  final sql.Database db = await initdb();
  if (city == '') {
    return -1;
  }

  Current cityinfo = await getCurrentData(city: city);
  if (cityinfo.timezone == 0) {
    return -1;
  } else {
    final data = {
      'city': city,
      'latitude': cityinfo.coord.lat,
      'longitude': cityinfo.coord.lon
    };
    int id = await db.insert('cities', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
}

// Fetch all cities
Future<List<Map>> getCities() async {
  final sql.Database db = await initdb();
  return db.query('cities', orderBy: "id");
}

// Read a single city by id
Future<List<Map<String, dynamic>>> getCity(int id) async {
  final sql.Database db = await initdb();
  return db.query('cities', where: "id = ?", whereArgs: [id], limit: 1);
}

// Update a city by id
Future<int> updateCity(
    int id, String city, String latitude, String longitude) async {
  final sql.Database db = await initdb();

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
Future<void> deleteCity(int id) async {
  final sql.Database db = await initdb();
  try {
    await db.delete("cities", where: "id = ?", whereArgs: [id]);
  } catch (err) {
    debugPrint("Something went wrong when deleting a city: $err");
  }
}
