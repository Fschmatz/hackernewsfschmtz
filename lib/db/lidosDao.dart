import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class lidosDao {

  static final _databaseName = "HN.db";
  static final _databaseVersion = 1;

  static final table = 'lidos';
  static final columnId = 'id';
  static final columnidTopStory = 'idTopStory';

  lidosDao._privateConstructor();
  static final lidosDao instance = lidosDao._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllStoriesLidosIds() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT idTopStory FROM $table');
  }
}