import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class LidosDao {

  static const _databaseName = "HN.db";
  static const _databaseVersion = 1;

  static const table = 'lidos';
  static const columnId = 'id';
  static const columnidTopStory = 'idTopStory';

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initDatabase();

  LidosDao._privateConstructor();
  static final LidosDao instance = LidosDao._privateConstructor();

  Future<Database> _initDatabase() async {
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