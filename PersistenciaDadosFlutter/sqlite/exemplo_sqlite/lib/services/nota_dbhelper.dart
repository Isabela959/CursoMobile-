//Arquivo para funcionar a conexão com a database
//instalar os pacotes sqflite e path_provider

import 'package:exemplo_sqlite/models/notas_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotaDBhelper {
  static Database? _database;

  static const String DB_NAME = "notas.db";
  static const String TABLE_NAME = "notas";
  static const String CREATE_TABLE_SQL = """CREATE TABLE IF NOT EXISTS $TABLE_NAME(
                                            id INTEGER PRIMARY KEY AUTOINCREMENT, 
                                            titulo TEXT NOT NULL, 
                                            conteudo TEXT NOT NULL)""";

//métodos
//iniciar conexão
Future<Database> get database async {
  if (_database != null){
    return _database!;
  }
  _database = await _initDataBase();
  return _database!;
}

Future<Database> _initDataBase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, DB_NAME);
  return await openDatabase(
    path, onCreate: (db, version) async {
      await db.execute(CREATE_TABLE_SQL);
    }, 
    version: 1,
  );
}

//métodos do CRUD

Future<int> insertNota(Nota nota) async{
  final db = await database;
  return await db.insert(TABLE_NAME, nota.toMap());
}

Future<List<Nota>> getNotas() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
  return maps.map((e) => Nota.fromMap(e)).toList();
}

Future<int> updateNota(Nota nota) async {
  if(nota.id == null){
    throw Exception("Impossível atualizar: Nota sem ID");
  }
  final db = await database;
  return await db.update(
    TABLE_NAME,
    nota.toMap(),
    where: "id = ?",
    whereArgs: [nota.id]
  );
}
Future<int> deleteNota(int id) async {
  final db = await database;
  return await db.delete(
    TABLE_NAME,
    where: "id = ?",
    whereArgs: [id] 
  );
}
}