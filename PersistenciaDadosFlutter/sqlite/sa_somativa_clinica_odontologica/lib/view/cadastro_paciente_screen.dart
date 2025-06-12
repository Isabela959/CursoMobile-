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

      await _controllerPaciente.criarPaciente(novoPaciente); // Insere o paciente no banco via controller

      // Navega para a tela inicial após o cadastro
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Paciente")), // Título da tela
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey, // Associa o formulário à chave para controle
          child: ListView(
            children: [
              // Campo para nome completo com validação e salvamento do valor
              TextFormField(
                decoration: InputDecoration(labelText: "Nome Completo"),
                validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                onSaved: (value) => _nome = value!, 
              ),
              // Campo para CPF
              TextFormField(
                decoration: InputDecoration(labelText: "CPF"),
                validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                onSaved: (value) => _cpf = value!, 
              ),
              // Campo para data de nascimento
              TextFormField(
                decoration: InputDecoration(labelText: "Data de Nascimento"),
                validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                onSaved: (value) => _dataNascimento = value!, 
              ),
              // Campo para telefone
              TextFormField(
                decoration: InputDecoration(labelText: "Telefone"),
                validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                onSaved: (value) => _telefone = value!, 
              ),
              // Campo para email
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                onSaved: (value) => _email = value!, 
              ),
              // Campo para histórico médico
              TextFormField(
                decoration: InputDecoration(labelText: "Histórico Médico"),
                validator: (value) => value!.isEmpty ? "Campo Obrigatório" : null,
                onSaved: (value) => _historicoMedico = value!, 
              ),
              SizedBox(height: 16),
              // Botão para salvar os dados e cadastrar o paciente
              ElevatedButton(
                onPressed: _salvarPaciente, 
                child: Text("Cadastrar Paciente"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
