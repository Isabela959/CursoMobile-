// Controller: gerencia a comunicação entre a interface e os dados

import '../models/paciente_model.dart';
import '../services/clinica_odontologica_db_helper.dart';

class PacienteController {
  // Instância do DBHelper para acessar o banco de dados
  final ClinicaOdontologicaDBHelper _dbHelper = ClinicaOdontologicaDBHelper();

  // Método para inserir um novo paciente no banco
  Future<int> criarPaciente(Paciente paciente) async {
    return await _dbHelper.createPaciente(paciente);
  }

  // Buscar todos os pacientes cadastrados
  Future<List<Paciente>> listarPacientes() async {
    return await _dbHelper.getPacientes();
  }

  // Buscar um paciente específico pelo ID
  Future<Paciente?> buscarPacientePorId(int id) async {
    return await _dbHelper.getPacienteById(id);
  }

  // Atualizar os dados de um paciente
  Future<int> atualizarPaciente(Paciente paciente) async {
    return await _dbHelper.updatePaciente(paciente);
  }

  // Deletar um paciente pelo ID
  Future<int> deletarPaciente(int id) async {
    return await _dbHelper.deletePaciente(id);
  }
}
