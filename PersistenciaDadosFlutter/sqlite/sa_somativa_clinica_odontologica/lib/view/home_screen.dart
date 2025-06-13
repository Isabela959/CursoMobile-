import 'package:flutter/material.dart';
import '../controllers/paciente_controller.dart'; // Controller responsável pela lógica
import '../models/paciente_model.dart'; // Modelo do paciente
import 'cadastro_paciente_screen.dart'; // Tela para cadastrar novo paciente
import 'prontuario_paciente_screen.dart'; // Tela que mostra o prontuário do paciente

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PacienteController _pacienteController =
      PacienteController(); // Controller instanciado
  List<Paciente> _pacientes = []; // Lista que armazenará os pacientes do banco
  bool _isLoading = true; // Flag para saber se está carregando dados

  @override
  void initState() {
    super.initState();
    _carregarDados(); // Chama a função assim que a tela é carregada
  }

  // Função que busca os pacientes do banco e atualiza a lista
  void _carregarDados() async {
    setState(() {
      _isLoading = true; // Ativa o indicador de carregamento
    });

    try {
      _pacientes =
          await _pacienteController.listarPacientes(); // Busca do banco
    } catch (e) {
      // Mostra erro se a busca falhar
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao carregar pacientes: $e")));
    } finally {
      setState(() {
        _isLoading = false; // Desativa o indicador de carregamento
      });
    }
  }

  // Função que deleta um paciente ao pressionar e segurar
  void _deletarPaciente(int id) async {
    try {
      await _pacienteController.deletarPaciente(id);
      _carregarDados(); // Atualiza a lista após exclusão
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Paciente deletado com sucesso")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao deletar paciente: $e")));
    }
  }

  // Método que constrói a interface visual
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clínica Odontológica"),
        backgroundColor: Color(0xFF6D83FF),
      ),
      body: Container(
        color: Colors.blue[50],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Text(
                "Pacientes",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _pacientes.isEmpty
                      ? Center(child: Text("Nenhum paciente cadastrado."))
                      : ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: _pacientes.length,
                          itemBuilder: (context, index) {
                            final paciente = _pacientes[index];
                            return Card(
                              color: Colors.white,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Color(0xFF6D83FF),
                                  child: Icon(Icons.person, color: Colors.white),
                                ),
                                title: Text(
                                  paciente.nome,
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  paciente.telefone,
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProntuarioPacienteScreen(
                                      pacienteId: paciente.id!,
                                    ),
                                  ),
                                ).then((_) => _carregarDados()),
                                onLongPress: () => _deletarPaciente(paciente.id!),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF6D83FF),
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CadastroPacienteScreen()),
        ).then((_) => _carregarDados()),
        tooltip: "Adicionar novo paciente",
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
