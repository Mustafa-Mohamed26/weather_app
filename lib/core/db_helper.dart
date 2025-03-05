import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/weather_model.dart';

class WeatherDatabase {
  static final WeatherDatabase instance = WeatherDatabase._init();
  static Database? _database;

  WeatherDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('weather.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE weather (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        city TEXT NOT NULL,
        temperature REAL NOT NULL,
        description TEXT NOT NULL,
        icon TEXT NOT NULL,
        humidity INTEGER NOT NULL,
        windSpeed REAL NOT NULL
      )
    ''');
  }

  Future<void> insertWeather(WeatherModel weather) async {
    final db = await instance.database;
    await db.insert(
      'weather',
      weather.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<WeatherModel?> getWeather() async {
    final db = await instance.database;
    final maps = await db.query('weather', limit: 1);

    if (maps.isNotEmpty) {
      return WeatherModel.fromJson(maps.first);
    }
    return null;
  }

  Future<void> deleteWeather() async {
    final db = await instance.database;
    await db.delete('weather');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
