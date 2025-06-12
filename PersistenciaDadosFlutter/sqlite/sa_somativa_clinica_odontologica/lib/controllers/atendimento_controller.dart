// Controller: gerencia a comunicação entre a interface e os dados

import '../models/atendimento_model.dart';
import '../services/clinica_odontologica_db_helper.dart';

class AtendimentoController {
  // Instância do DBHelper para lidar com banco de dados
  final ClinicaOdontologicaDBHelper _dbHelper = ClinicaOdontologicaDBHelper();

  // Inserir um novo atendimento para um paciente
  Future<int> createAtendimento(Atendimento atendimento) async {
    return await _dbHelper.insertAtendimento(atendimento);
  }

  // Buscar todos os atendimentos de um paciente (usando o ID dele)
  Future<List<Atendimento>> listarAtendimentosDoPaciente(int pacienteId) async {
    return await _dbHelper.getAtendimentosDoPaciente(pacienteId);
  }

  // Deletar um atendimento pelo ID
  Future<int> deletarAtendimento(int id) async {
    return await _dbHelper.deleteAtendimento(id);
  }
}
