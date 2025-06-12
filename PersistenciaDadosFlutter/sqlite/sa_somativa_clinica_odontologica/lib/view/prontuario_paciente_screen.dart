import 'package:flutter/material.dart';
import 'package:sa_somativa_clinica_odontologica/models/atendimento_model.dart';
import 'package:sa_somativa_clinica_odontologica/models/paciente_model.dart';
import 'package:sa_somativa_clinica_odontologica/view/novo_atendimento_screen.dart';
import '../services/clinica_odontologica_db_helper.dart';

class ProntuarioPacienteScreen extends StatefulWidget {
  final int pacienteId;

  const ProntuarioPacienteScreen({super.key, required this.pacienteId});

  @override
  State<ProntuarioPacienteScreen> createState() => _ProntuarioPacienteScreenState();
}

class _ProntuarioPacienteScreenState extends State<ProntuarioPacienteScreen> {
  final ClinicaOdontologicaDBHelper _dbHelper = ClinicaOdontologicaDBHelper();

  bool _isLoading = true;
  Paciente? _paciente;
  List<Atendimento> _atendimentos = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _paciente = await _dbHelper.getPacienteById(widget.pacienteId);
      _atendimentos = await _dbHelper.getAtendimentosDoPaciente(widget.pacienteId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar dados: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deletarAtendimento(int atendimentoId) async {
    try {
      await _dbHelper.deleteAtendimento(atendimentoId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Atendimento deletado com sucesso.")),
      );
      await _carregarDados(); // Atualiza a tela
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
        backgroundColor: const Color(0xFF6D83FF),
        ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _paciente == null
              ? Center(child: Text("Paciente não encontrado."))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nome: ${_paciente!.nome}", style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10),
                      Text("CPF: ${_paciente!.cpf}"),
                      Text("Nascimento: ${_paciente!.dataNascimento}"),
                      Text("Telefone: ${_paciente!.telefone}"),
                      Text("E-mail: ${_paciente!.email}"),
                      Text("Histórico Médico: ${_paciente!.historicoMedico}"),
                      Divider(height: 32),
                      Text("Atendimentos:", style: TextStyle(fontSize: 20)),
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
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NovoAtendimentoScreen(pacienteId: widget.pacienteId),
                                  ),
                                  ).then((_) => _carregarDados());
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
