import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sa_somativa_clinica_odontologica/models/atendimento_model.dart';
import '../services/clinica_odontologica_db_helper.dart';
import 'prontuario_paciente_screen.dart';

class NovoAtendimentoScreen extends StatefulWidget {
  final int pacienteId;

  const NovoAtendimentoScreen({super.key, required this.pacienteId});

  @override
  State<StatefulWidget> createState() {
    return _NovoAtendimentoScreenState();
  }
}

class _NovoAtendimentoScreenState extends State<NovoAtendimentoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dbHelper = ClinicaOdontologicaDBHelper();

  late String _procedimento;
  late String _dentesEnvolvidos;
  late String _observacoes;
  late double _valor;

  DateTime _dataSelecionada = DateTime.now();
  TimeOfDay _horaSelecionada = TimeOfDay.now();

  // Selecionar Data
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

  // Selecionar Hora
  _selecionarHora(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _horaSelecionada);
    if (picked != null && picked != _horaSelecionada) {
      setState(() {
        _horaSelecionada = picked;
      });
    }
  }

  // Salvar Atendimento
  _salvarAtendimento() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final dataFormatada = DateFormat('yyyy-MM-dd').format(_dataSelecionada);
      final horaFormatada =
          '${_horaSelecionada.hour.toString().padLeft(2, '0')}:${_horaSelecionada.minute.toString().padLeft(2, '0')}';

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
        await _dbHelper.insertAtendimento(novoAtendimento);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Atendimento salvo com sucesso")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProntuarioPacienteScreen(pacienteId: widget.pacienteId),
          ),
        );
      } catch (e) {
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
      appBar: AppBar(title: Text("Novo Atendimento"),
      backgroundColor: Color(0xFF6D83FF),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Procedimento"),
                validator: (value) =>
                    value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (newValue) => _procedimento = newValue!,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "Dentes Envolvidos"),
                validator: (value) =>
                    value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (newValue) => _dentesEnvolvidos = newValue!,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Data: ${dataFormatada.format(_dataSelecionada)}"),
                  TextButton(
                    onPressed: () => _selecionarData(context),
                    child: Text("Selecionar Data"),
                  )
                ],
              ),
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
              TextFormField(
                decoration: InputDecoration(labelText: "Observações"),
                onSaved: (newValue) => _observacoes = newValue ?? "",
              ),
              SizedBox(height: 10),
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
