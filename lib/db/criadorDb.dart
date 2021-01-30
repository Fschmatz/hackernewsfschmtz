import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class criadorDB {

  static final _databaseName = "HN.db";
  static final _databaseVersion = 1;

  criadorDB._privateConstructor(); //_privateConstructor
  static final criadorDB instance = criadorDB._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  initDatabase() async { //_initDatabase();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // Código SQL para criar o banco de dados e a tabela,
  // só roda uma vez quando detecta banco nulo
  Future _onCreate(Database db, int version) async {
    print("OI DO CRIADOR DE DB");

    await db.execute('''
    
          CREATE TABLE lidos (          
            id INTEGER PRIMARY KEY,
            idTopStory INTEGER NOT NULL                      
          )
          
          ''');

    //CRIAR 40 ITENS FALSOS, por enquanto só 40 (suficiente?)
    Batch batch = db.batch();
    int contador = 1;
    while (contador <= 40){
      batch.insert('lidos', {'id': contador, 'idTopStory': contador});
      contador++;
    }
    await batch.commit(noResult: true);


    //CRIA TRIGGER add 1, deleta 1
    await db.execute('''
    
          CREATE TRIGGER deleteNoAdd
          AFTER INSERT ON lidos           
          BEGIN
            DELETE FROM lidos WHERE rowid IN (SELECT rowid FROM lidos LIMIT 1);
          END;
          
          ''');

  }

}

