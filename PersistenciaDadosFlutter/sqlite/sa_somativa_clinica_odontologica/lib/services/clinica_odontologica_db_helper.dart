//Service: Gerencia o banco de dados e cria as operações CRUD para o Controller

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/paciente_model.dart';
import '../models/atendimento_model.dart';

class ClinicaOdontologicaDBHelper {
  // Objeto de conexão com o banco SQLite
  static Database? _database;

  // Singleton: só permite uma instância do helper
  static final ClinicaOdontologicaDBHelper _instance = ClinicaOdontologicaDBHelper._internal();
  ClinicaOdontologicaDBHelper._internal();
  factory ClinicaOdontologicaDBHelper() => _instance;

  // Getter que retorna a conexão com o banco
  Future<Database> get database async {
    if (_database != null) {
      return _database!; // Se já está pronto, retorna
    } else {
      _database = await _initDatabase(); // Senão, inicializa
      return _database!;
    }
  }

  // Inicializa o banco e define o caminho do arquivo
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath(); // Pega o caminho padrão dos bancos
    final path = join(dbPath, "clinica_odontologica.db"); // Define o nome do arquivo do banco

    // Abre o banco (ou cria, se não existir)
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDB,
    );
  }

  // Método chamado na criação do banco — cria as tabelas
  Future<void> _onCreateDB(Database db, int version) async {
    // Criação da tabela de pacientes
    await db.execute('''
      CREATE TABLE IF NOT EXISTS paciente (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        cpf TEXT,
        data_nascimento TEXT,
        telefone TEXT,
        email TEXT,
        historico_medico TEXT
      )
    ''');
    print("Tabela paciente criada.");

    // Criação da tabela de atendimentos, com chave estrangeira para paciente
    await db.execute('''
      CREATE TABLE IF NOT EXISTS atendimento (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pacienteId INTEGER,
        data TEXT,
        hora TEXT,
        procedimento TEXT,
        dentes_envolvidos TEXT,
        observacoes TEXT,
        valor REAL,
        FOREIGN KEY (pacienteId) REFERENCES paciente(id) ON DELETE CASCADE
      )
    ''');
    print("Tabela atendimento criada.");
  }

                              // MÉTODOS CRUD - PACIENTE 

  // Inserir um novo paciente
  Future<int> createPaciente(Paciente paciente) async {
    final db = await database;
    return await db.insert("paciente", paciente.toMap());
  }

  // Buscar todos os pacientes cadastrados
  Future<List<Paciente>> getPacientes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("paciente");
    return maps.map((e) => Paciente.fromMap(e)).toList();
  }

  // Buscar um único paciente pelo ID
  Future<Paciente?> getPacienteById(int id) async {
    final db = await database;
    final maps = await db.query("paciente", where: "id = ?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Paciente.fromMap(maps.first);
    }
    return null;
  }

  // Atualizar os dados de um paciente
  Future<int> updatePaciente(Paciente paciente) async {
    final db = await database;
    return await db.update(
      "paciente",
      paciente.toMap(),
      where: "id = ?",
      whereArgs: [paciente.id],
    );
  }

  // Deletar um paciente (se tiver atendimentos, eles também serão apagados por causa do ON DELETE CASCADE)
  Future<int> deletePaciente(int id) async {
    final db = await database;
    return await db.delete("paciente", where: "id = ?", whereArgs: [id]);
  }

                              // MÉTODOS CRUD - ATENDIMENTO 

  // Inserir novo atendimento
  Future<int> insertAtendimento(Atendimento atendimento) async {
    final db = await database;
    return await db.insert("atendimento", atendimento.toMap());
  }

  // Buscar todos os atendimentos de um paciente
  Future<List<Atendimento>> getAtendimentosDoPaciente(int pacienteId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "atendimento",
      where: "pacienteId = ?",
      whereArgs: [pacienteId],
    );
    return maps.map((e) => Atendimento.fromMap(e)).toList();
  }

  // Deletar atendimento por ID
  Future<int> deleteAtendimento(int id) async {
    final db = await database;
    return await db.delete("atendimento", where: "id = ?", whereArgs: [id]);
  }
}
