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
        title: Text("Prontuário do Paciente"),
        backgroundColor: const Color(0xFF6D83FF), // Cor azul personalizada
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Indicador enquanto carrega
          : _paciente == null
              ? Center(child: Text("Paciente não encontrado.")) // Caso não ache paciente
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dados básicos do paciente
                      Text("Nome: ${_paciente!.nome}", style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10),
                      Text("CPF: ${_paciente!.cpf}"),
                      Text("Nascimento: ${_paciente!.dataNascimento}"),
                      Text("Telefone: ${_paciente!.telefone}"),
                      Text("E-mail: ${_paciente!.email}"),
                      Text("Histórico Médico: ${_paciente!.historicoMedico}"),
                      Divider(height: 32),
                      Text("Atendimentos:", style: TextStyle(fontSize: 20)),

                      // Lista de atendimentos ou mensagem se vazio
                      _atendimentos.isEmpty
                          ? Center(child: Text("Nenhum atendimento registrado."))
                          : Expanded(
                              child: ListView.builder(
                                itemCount: _atendimentos.length,
                                itemBuilder: (context, index) {
                                  final atendimento = _atendimentos[index];
                                  return Card(
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: ListTile(
                                      title: Text(atendimento.procedimento),
                                      subtitle: Text("Data: ${atendimento.data} - Hora: ${atendimento.hora}"),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deletarAtendimento(atendimento.id!),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                      SizedBox(height: 16),

                      // Botão para criar novo atendimento
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NovoAtendimentoScreen(pacienteId: widget.pacienteId),
                              ),
                            ).then((_) => _carregarDados()); // Recarrega após voltar da tela
                          },
                          icon: Icon(Icons.note),
                          label: Text("Novo Atendimento"),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
