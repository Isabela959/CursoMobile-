// classe de ajuda para conexão com o banco de dados

import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/pet_model.dart';

class PetShopDBHelper{ // fazer conexão singleton
  // static = se refere a classe, não ao objeto
  static Database? _database; // obj SQlite conexão com BD

  //classe do tipo Singleton = só posso instanciar um objeto por vez. Tem que eliminar o outro para poder fabrir um novo objeto
  //Um código por vez
  static final PetShopDBHelper _instance = PetShopDBHelper._internal();
  
  PetShopDBHelper._internal(); 
  factory PetShopDBHelper(){ 
    return _instance;
  }

  //verificação do banco de dados -> verificar se já foi criado, e se está aberto
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "petshop.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDB
    );
  }

  //método para criar as tabelas
  _onCreateDB(Database db, int version) async{
    // Cria a tabela 'pets'
    await db.execute('''
      CREATE TABLE IF NOT EXISTS pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        raca TEXT,
        nome_dono TEXT,
        telefone_dono TEXT
      )
    ''');
    print("banco pets criado");

    // Cria a tabela 'consultas'
    await db.execute('''
      CREATE TABLE IF NOT EXISTS consultas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pet_id INTEGER,
        data_hora TEXT, 
        tipo_servico TEXT,
        observacao TEXT,
        FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE
      )
    ''');
    print("banco consultas criado");
  }

  //verifica se o banco já foi criado, caso contrário inicia a conexão
  Future<Database> get database async{
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
    return maps.map((e) => Pet.fromMap(e)).toList(); //factory do BD -> objeto
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