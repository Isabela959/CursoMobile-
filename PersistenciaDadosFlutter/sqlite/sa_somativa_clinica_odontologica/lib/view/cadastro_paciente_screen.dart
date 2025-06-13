import 'package:flutter/material.dart';
import 'package:sa_somativa_clinica_odontologica/controllers/paciente_controller.dart';
import 'package:sa_somativa_clinica_odontologica/models/paciente_model.dart';
import 'package:sa_somativa_clinica_odontologica/view/home_screen.dart';

class CadastroPacienteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CadastroPacienteScreenState(); 
}

class _CadastroPacienteScreenState extends State<CadastroPacienteScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave para controlar o estado do formulário
  final _controllerPaciente = PacienteController(); // Controller para gerenciar os dados do paciente

  // Variáveis que armazenam os dados preenchidos no formulário
  late String _nome;
  late String _cpf;
  late String _dataNascimento;
  late String _telefone;
  late String _email;
  late String _historicoMedico;

  // Função que salva os dados do paciente após validar o formulário
  _salvarPaciente() async {
    if (_formKey.currentState!.validate()) { // Verifica se o formulário está válido
      _formKey.currentState!.save();  // Salva os valores do formulário nas variáveis

      // Cria um objeto Paciente com os dados preenchidos
      final novoPaciente = Paciente(
        nome: _nome, 
        cpf: _cpf, 
        dataNascimento: _dataNascimento, 
        telefone: _telefone, 
        email: _email, 
        historicoMedico: _historicoMedico);

      await _controllerPaciente.criarPaciente(novoPaciente); // Insere o paciente no banco pelo controller

      // Navega para a tela inicial após o cadastro
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clínica Odontológica"), // Título da tela
      backgroundColor: Color(0xFF6D83FF),), 
      body: Container(
        color: Colors.blue[50], // Fundo azul claro
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  "Cadastro de Paciente",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                // Campo para nome completo com validação e salvamento do valor
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nome Completo",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                  onSaved: (value) => _nome = value!,
                ),
                SizedBox(height: 12),
                // Campo para CPF
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "CPF",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                  onSaved: (value) => _cpf = value!,
                ),
                SizedBox(height: 12),
                // Campo para data de nascimento
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Data de Nascimento",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                  onSaved: (value) => _dataNascimento = value!,
                ),
                SizedBox(height: 12),
                // Campo para telefone
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Telefone",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                  onSaved: (value) => _telefone = value!,
                ),
                SizedBox(height: 12),
                // Campo para email
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                  onSaved: (value) => _email = value!,
                ),
                SizedBox(height: 12),
                // Campo para histórico médico
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Histórico Médico",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                  onSaved: (value) => _historicoMedico = value!,
                ),
                SizedBox(height: 20),
                // Botão para salvar os dados e cadastrar o paciente
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _salvarPaciente,
                  child: Text("Cadastrar Paciente", style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
