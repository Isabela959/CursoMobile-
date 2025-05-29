// classe de ajuda para conexão com o banco de dados

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PetShopDBHelper{ // fazer conexão singleton
  // static = se refere a classe, não ao objeto
  static Database? _database; // obj SQlite conexão com BD

  //classe do tipo Singleton = só posso instanciar um objeto por vez. Tem que eliminar o outro para poder fabrir um novo objeto
  //Um código por vez
  static final PetShopDBHelper _instance = PetShopDBHelper._internal();
  
  PetShopDBHelper._internal(); 
  factory PetShopDBHelper(){ return _instance;}

  //verificação do banco de dados -> verificar se já foi criado, e se está aberto
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasePath();
    final path = join(dbPath, "petshop.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDB
    );
  }

  //método para criar as tabelas
  _onCreateDB(Database db, int version) async{
    //criar a Tabela do Pet
    await db.execute(
      """CREATE TABLE IF NOT EXISTS pet(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          raca TEXT NOT NULL
          nome_dono TEXT NOT NULL, 
          telefone_dono TEXT NOT NULL,)"""
    );
    print("tabela pets Criada");
    await db.execute(
      """CREATE TABLE IF NOT EXISTS consultas(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pet_id INTEGER NOT NULL,
      data_hora TEXT NOT NULL,
      tipo_servico TEXT NOT NULL,
      observacao TEXT NOT NULL,
      FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE)"""
    );
    print("tabela consulta criada");
  }

  //verifica se o banco já foi criado, caso contrário inicia a conexão
  Future<DataBase> get database async{
    if(_database !=null){
      return _database!;
    }else{
      _database = await _initDatabase();
      return _database!;
    }
  }

  // métodos do CRUD - PETS
  Future<int> insertPet(Pet pet) async {
    final db = await database; //verifica a conexão
    return db.insert("pets",pet.toMap()); //inserir o dado no banco
  }

  Future<List<Pet>> getPets() async{
    final db = await database; // verifica a conexão
    final List<Map<String,dynamic>> maps = await db.query("pets"); // pegar os dados do banco
    return maps.map((r) => Pet.fromMap(e)).toList(); //factory do BD -> objeto
  }

  Future<Pet?> getPetById(int id) async{
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(
      "pets",
      whereArgs: [id]);
      if (maps.isEmpty) {
        return null;
      }else{
        Pet.fromMap(maps.first);
      }
    }

  Future<int> deletePet(int id) async{
    final db = await database;
    return await db.delete("pets", where: "id=?", whereArgs: [id]);
  } //DELETE  ON CASCADE  na tabela Consulta

  //CRUD E CRIAR o Banco de Dados das Consultas

  Future<int> insertConsulta(Consulta consulta) async{
    final db = await database;
    return await db.insert("consultas", consulta.toMap()); // insere a consulta no DB
  }

  Future<List<Consulta>> getConsultasForPet(int petId) async{
    final db = await database;
    //consulta por PET específico 
    List<Map<String,dynamic>> maps = await db.query(
      "consultas", where: "pet_id =?", whereArgs: [petId]);
      //converter a map para objeto
      return maps.map((e)=> Consulta.fromMap(e)).toList();
      //toList() -> forma abreviada de escrever um laço de repetição (forEach)
      // Faz cada um dos elementos até acabar
  }

  Future<int> deleteConsulta(int id) async{
    final db = await database;
    return db.delete("consultas", where: "id=?", whereArgs: [id]);
    //DELETE FROM TABLE consultas where id = ?
  }
}