// página de agendamento de consultas e serviços do PET
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sa_petshop/controllers/consulta_controller.dart';
import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/view/detalhe_pet_screen.dart';

//classe que recebe as mudanças de state
class AgendaConsultaScreen extends StatefulWidget {
  //atributo 
  final int petId;

  AgendaConsultaScreen({super.key, required this.petId});

  @override
  State<StatefulWidget> createState() {
    return _AgendaConsultaScreenState();
  }
}

//classe que constroi a tela (build)
class _AgendaConsultaScreenState extends State<AgendaConsultaScreen>{
  final _formKey = GlobalKey<FormState>();
  final _consultaController = ConsultaController();

  late String _tipoServico; // nula, porém recebe o valor posteriormente
  late String _observacao;
  DateTime _dataSelecionada = DateTime.now(); //pega o dia Atual
  TimeOfDay _horaSelecionada = TimeOfDay.now(); //pega a hora atual

  //método para Selecionar Data 
  _selecionarData(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: _dataSelecionada,
      firstDate: DateTime.now(), 
      lastDate: DateTime(2030));
      if(picked != null && picked != _dataSelecionada){
        setState(() {
          _dataSelecionada = picked;
        });
      }
  }
  //método para Selecionar hora
  _selecionarHora(BuildContext context) async{
    final TimeOfDay? picked = await showTimePicker(
      context: context, 
      initialTime: _horaSelecionada);
      if(picked != null && picked != _horaSelecionada){ // != significa diferente
        setState(() {
          _horaSelecionada = picked;
        });
      } 
  }

  //método para Salvar Consulta
  _salvarAgendamento() async {
    if (_formKey.currentState!.validate()){
      _formKey.currentState!.save(); // salvo as informações do formulário nas variáveis selecionadas anteriormente

      final DateTime dataAgendamento = DateTime(
        _dataSelecionada.year,
        _dataSelecionada.month,
        _dataSelecionada.day,
        _horaSelecionada.hour,
        _horaSelecionada.minute);

        //criar a Consulta
        final newConsulta = Consulta(
          petId: widget.petId, 
          dataHora: dataAgendamento, 
          tipoServico: _tipoServico, 
          observacao: _observacao.isEmpty ? "." : _observacao);

          //Armazenar no BD
          try { //tratativa de erro
            await _consultaController.createConsulta(newConsulta);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Agendamento Realizado com Sucesso")));
            Navigator.push(context,
              MaterialPageRoute(builder: (context)=> DetalhePetScreen(petId: widget.petId)));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Exception: $e")));
          }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataFormatada = DateFormat("dd/MM/yyyy");
    final horaFormatada = DateFormat("HH:mm");

    return Scaffold(
      appBar: AppBar(title: Text("Novo Agendamento"),),
      body: Padding(padding: EdgeInsets.all(16), child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Tipo de Serviço"),
              validator: (value) => value!.isEmpty ? "Campo não Preenchido": null,
              onSaved: (newValue) => _tipoServico = newValue!,
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Data: ${dataFormatada.format(_dataSelecionada)}"),
                TextButton(onPressed: ()=> _selecionarData(context), child: Text("Selecionar Data"))
              ],
            ),
            Row(
              children: [
                Text("Hora: ${horaFormatada.format(
                  DateTime(0,0,0,_horaSelecionada.hour,_horaSelecionada.minute))}"),
                  TextButton(onPressed: ()=>_selecionarHora(context), child: Text("Selecionar Hora"))
              ],
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(labelText: "Observação"),
              maxLength: 3,
              onSaved: (newValue) => _observacao = newValue!,
            ),
            ElevatedButton(onPressed: _salvarAgendamento, child: Text("criar Agendamento"))
          ],
        )),),
    );
  }
}
