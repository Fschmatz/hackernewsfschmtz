import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class criadorDB {

  static final _databaseName = "HN.db";
  static final _databaseVersion = 1;

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await initDatabase();

  criadorDB._privateConstructor();
  static final criadorDB instance = criadorDB._privateConstructor();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {

    await db.execute('''
    
          CREATE TABLE lidos (          
            id INTEGER PRIMARY KEY,
            idTopStory INTEGER NOT NULL                      
          )
          
          ''');


    Batch batch = db.batch();
    for(int i = 1; i <= 50 ; i++) {
      batch.insert('lidos', {'id': i, 'idTopStory': i});
    }
    await batch.commit(noResult: true);



    //TRIGGER add 1, delete 1
    await db.execute('''
    
          CREATE TRIGGER deleteNoAdd
          AFTER INSERT ON lidos           
          BEGIN
            DELETE FROM lidos WHERE rowid IN (SELECT rowid FROM lidos LIMIT 1);
          END;
          
          ''');

  }

}

