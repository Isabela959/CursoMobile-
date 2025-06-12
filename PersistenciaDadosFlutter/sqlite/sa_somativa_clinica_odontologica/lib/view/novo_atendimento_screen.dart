// Importações necessárias
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sa_somativa_clinica_odontologica/models/atendimento_model.dart';
import '../services/clinica_odontologica_db_helper.dart';
import 'prontuario_paciente_screen.dart';

// Tela para cadastrar um novo atendimento
class NovoAtendimentoScreen extends StatefulWidget {
  final int pacienteId; // ID do paciente que receberá o atendimento

  const NovoAtendimentoScreen({super.key, required this.pacienteId});

  @override
  State<StatefulWidget> createState() {
    return _NovoAtendimentoScreenState();
  }
}

class _NovoAtendimentoScreenState extends State<NovoAtendimentoScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave para validar o formulário
  final _dbHelper = ClinicaOdontologicaDBHelper(); // Acesso ao banco de dados

  // Variáveis para armazenar os dados do formulário
  late String _procedimento;
  late String _dentesEnvolvidos;
  late String _observacoes;
  late double _valor;

  // Armazena a data e hora selecionadas
  DateTime _dataSelecionada = DateTime.now();
  TimeOfDay _horaSelecionada = TimeOfDay.now();

  // Função para abrir o seletor de data
  _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _dataSelecionada) {
      setState(() {
        _dataSelecionada = picked;
      });
    }
  }

  // Função para abrir o seletor de hora
  _selecionarHora(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _horaSelecionada);
    if (picked != null && picked != _horaSelecionada) {
      setState(() {
        _horaSelecionada = picked;
      });
    }
  }

  // Função para salvar o atendimento no banco de dados
  _salvarAtendimento() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Salva os dados do formulário

      // Formata data e hora
      final dataFormatada = DateFormat('yyyy-MM-dd').format(_dataSelecionada);
      final horaFormatada =
          '${_horaSelecionada.hour.toString().padLeft(2, '0')}:${_horaSelecionada.minute.toString().padLeft(2, '0')}';

      // Cria objeto de atendimento com os dados
      final novoAtendimento = Atendimento(
        pacienteId: widget.pacienteId,
        data: dataFormatada,
        hora: horaFormatada,
        procedimento: _procedimento,
        dentesEnvolvidos: _dentesEnvolvidos,
        observacoes: _observacoes.isEmpty ? "." : _observacoes,
        valor: _valor,
      );

      try {
        // Insere no banco de dados
        await _dbHelper.insertAtendimento(novoAtendimento);

        // Mostra mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Atendimento salvo com sucesso")),
        );

        // Vai para a tela de prontuário do paciente
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProntuarioPacienteScreen(pacienteId: widget.pacienteId),
          ),
        );
      } catch (e) {
        // Mostra erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataFormatada = DateFormat("dd/MM/yyyy");
    final horaFormatada = DateFormat("HH:mm");

    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Atendimento"),
        backgroundColor: Color(0xFF6D83FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // Formulário com validação
          child: ListView(
            children: [
              // Campo de procedimento
              TextFormField(
                decoration: InputDecoration(labelText: "Procedimento"),
                validator: (value) =>
                    value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (newValue) => _procedimento = newValue!,
              ),
              SizedBox(height: 10),

              // Campo de dentes envolvidos
              TextFormField(
                decoration: InputDecoration(labelText: "Dentes Envolvidos"),
                validator: (value) =>
                    value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (newValue) => _dentesEnvolvidos = newValue!,
              ),
              SizedBox(height: 10),

              // Seleção de data
              Row(
                children: [
                  Text("Data: ${dataFormatada.format(_dataSelecionada)}"),
                  TextButton(
                    onPressed: () => _selecionarData(context),
                    child: Text("Selecionar Data"),
                  )
                ],
              ),

              // Seleção de hora
              Row(
                children: [
                  Text(
                    "Hora: ${horaFormatada.format(DateTime(0, 0, 0, _horaSelecionada.hour, _horaSelecionada.minute))}",
                  ),
                  TextButton(
                    onPressed: () => _selecionarHora(context),
                    child: Text("Selecionar Hora"),
                  )
                ],
              ),
              SizedBox(height: 10),

              // Campo de observações (opcional)
              TextFormField(
                decoration: InputDecoration(labelText: "Observações"),
                onSaved: (newValue) => _observacoes = newValue ?? "",
              ),
              SizedBox(height: 10),

              // Campo de valor
              TextFormField(
                decoration: InputDecoration(labelText: "Valor (R\$)"),
                keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    value!.isEmpty ? "Informe o valor" : null,
                onSaved: (newValue) =>
                    _valor = double.tryParse(newValue!) ?? 0.0,
              ),
              SizedBox(height: 20),

              // Botão para salvar o atendimento
              ElevatedButton(
                onPressed: _salvarAtendimento,
                child: Text("Salvar Atendimento"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
