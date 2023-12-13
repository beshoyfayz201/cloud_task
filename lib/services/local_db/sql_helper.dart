import 'dart:io';
import 'package:cloud_task/home/data/models/real_state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'real_estate';
  static const String settingsTableName = 'settings';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}real_estate.db';
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        name TEXT,
        description TEXT,
        location TEXT,
        price INTEGER,
        image_url TEXT
        
      )
    ''');
    await db.execute('''
      CREATE TABLE $settingsTableName (
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');
  }

  Future<void> insertRealEstate(RealEstateModel realEstate) async {
    final Database db = await instance.database;
    await db.insert(
      tableName,
      realEstate.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertSettings(String key, String value) async {
    final Database db = await instance.database;
    await db.insert(
      settingsTableName,
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<RealEstateModel>> getRealEstates() async {
    final Database db = await instance.database;
    
    final List<Map<String, dynamic>> maps =
        await db.query(DatabaseHelper.tableName);
    return List.generate(maps.length, (i) {
      return RealEstateModel.fromJson(maps[i]);
    });
  }

  Future<int?> getSetting(String key) async {
    final Database db = await instance.database;
    List<Map<String, dynamic>> result =
        await db.query(settingsTableName, where: 'key = ?', whereArgs: [key]);

    if (result.isNotEmpty) {
      return int.parse(result.first['value']);
    }

    return null;
  }
}
