import 'package:flutter/material.dart';
import 'package:sa_somativa_clinica_odontologica/models/atendimento_model.dart'; // Modelo de atendimento
import 'package:sa_somativa_clinica_odontologica/models/paciente_model.dart'; // Modelo de paciente
import 'package:sa_somativa_clinica_odontologica/view/novo_atendimento_screen.dart'; // Tela para criar novo atendimento
import '../services/clinica_odontologica_db_helper.dart'; // Helper para operações no banco

// Tela que mostra o prontuário (dados + atendimentos) de um paciente
class ProntuarioPacienteScreen extends StatefulWidget {
  final int pacienteId; // ID do paciente para carregar

  const ProntuarioPacienteScreen({super.key, required this.pacienteId});

  @override
  State<ProntuarioPacienteScreen> createState() => _ProntuarioPacienteScreenState();
}

class _ProntuarioPacienteScreenState extends State<ProntuarioPacienteScreen> {
  final ClinicaOdontologicaDBHelper _dbHelper = ClinicaOdontologicaDBHelper(); // Instância do DB helper

  bool _isLoading = true; // Indica se está carregando os dados
  Paciente? _paciente; // Dados do paciente
  List<Atendimento> _atendimentos = []; // Lista de atendimentos do paciente

  @override
  void initState() {
    super.initState();
    _carregarDados(); // Ao iniciar, carrega dados do paciente e atendimentos
  }

  // Função para carregar os dados do paciente e seus atendimentos do banco
  Future<void> _carregarDados() async {
    setState(() {
      _isLoading = true; // Inicia indicador de carregamento
    });

    try {
      _paciente = await _dbHelper.getPacienteById(widget.pacienteId); // Busca paciente
      _atendimentos = await _dbHelper.getAtendimentosDoPaciente(widget.pacienteId); // Busca atendimentos
    } catch (e) {
      // Se der erro, mostra mensagem
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar dados: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false; // Para indicador de carregamento
      });
    }
  }

  // Função para deletar um atendimento pelo ID
  Future<void> _deletarAtendimento(int atendimentoId) async {
    try {
      await _dbHelper.deleteAtendimento(atendimentoId); // Deleta atendimento no DB
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Atendimento deletado com sucesso.")),
      );
      await _carregarDados(); // Atualiza a lista após exclusão
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao deletar: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clínica Odontológica"),
        backgroundColor: const Color(0xFF6D83FF), // Cor azul personalizada
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _paciente == null
              ? Center(child: Text("Paciente não encontrado."))
              : Container(
                  color: Colors.blue[50], // Fundo azul claro
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                        child: Text(
                          "Prontuário do Paciente",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.08),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _paciente!.nome,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text("CPF: ${_paciente!.cpf}", style: TextStyle(fontSize: 16)),
                            Text("Nascimento: ${_paciente!.dataNascimento}", style: TextStyle(fontSize: 16)),
                            Text("Telefone: ${_paciente!.telefone}", style: TextStyle(fontSize: 16)),
                            Text("E-mail: ${_paciente!.email}", style: TextStyle(fontSize: 16)),
                            Text("Histórico Médico: ${_paciente!.historicoMedico}", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Text("Atendimentos:", style: TextStyle(fontSize: 20, color: Colors.blue[700], fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Expanded(
                        child: _atendimentos.isEmpty
                            ? Center(child: Text("Nenhum atendimento registrado."))
                            : ListView.builder(
                                itemCount: _atendimentos.length,
                                itemBuilder: (context, index) {
                                  final atendimento = _atendimentos[index];
                                  return Card(
                                    color: Colors.white,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: ListTile(
                                      title: Text(
                                        atendimento.procedimento,
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Data: ${atendimento.data} - Hora: ${atendimento.hora}",
                                        style: TextStyle(color: Colors.grey[700]),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red[400]),
                                        onPressed: () => _deletarAtendimento(atendimento.id!),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NovoAtendimentoScreen(pacienteId: widget.pacienteId),
                              ),
                            ).then((_) => _carregarDados());
                          },
                          icon: Icon(Icons.note_add),
                          label: Text("Novo Atendimento", style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
