import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/consulta_controller.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sa_petshop/view/agenda_consulta_screen.dart';

class DetalhePetScreen extends StatefulWidget {
  final int petId; // receber o PetId -> atributo

  //construtor -> pega o Id do Pet
  const DetalhePetScreen({
    super.key, required this.petId
  });

  @override
  State<StatefulWidget> createState() {
    return _DetalhePetScreenState();
  }
}

class _DetalhePetScreenState extends State<DetalhePetScreen>{
  //build da Tela
  //atributos
  final PetController _petController = PetController();
  final ConsultaController _consultaController = ConsultaController();

  bool _isLoading = true;

  Pet? _pet; // pode ser inicialmente nulo

  List<Consulta> _consultas = [];

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    _carregarDados();
  }

  _carregarDados() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _pet = await _petController.readPetById(widget.petId); // vai carregar as info do PET
      _consultas = await _consultaController.readConsultaForPet(widget.petId);
     // vai carregar as infos das consultas do PET
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e"))
      );
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    //TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Detalhe do Pet"),),
      body: _isLoading
      ? Center(child: CircularProgressIndicator(),)
      : _pet==null //verifica se o pet foi encontrado
      ? Center(child: Text("Erro ao Carregar o PET"),)
      : Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome: ${_pet!.nome}", style: TextStyle(fontSize: 20),),
            Text("Nome: ${_pet!.raca}"),
            Text("Nome: ${_pet!.nomeDono}"),
            Text("Nome: ${_pet!.telefoneDono}"),
            Divider(),
            Text("Consultas:",style: TextStyle(fontSize: 20),),
              //operador Ternário par consultas
              _consultas.isEmpty
              ? Center(child: Text("Não Existe Agendamentos para o Pet"),)
              : Expanded(child: ListView.builder(
                itemCount: _consultas.length,
                itemBuilder: (context, index){
                  final consulta = _consultas[index]; //elemento da lista
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(consulta.tipoServico),
                      subtitle: Text(consulta.dataHoraFormatada),
                      trailing: IconButton(onPressed: ()=> _deleteConsulta(consulta.id!),
                      icon: Icon(Icons.delete, color: Colors.red,))
                    ),
                  );
                },
              ))
          ],
        )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=> Navigator.push(context, 
          MaterialPageRoute(builder: (context)=> AgendaConsultaScreen(petId: widget.petId)))),
    );
  }

  void _deleteConsulta(int consultaId) async {
    try {
      // deletar consulta
      await _consultaController.deleteConsulta(consultaId);
      //recarregar a lista de consulta
      await _consultaController.readConsultaForPet(widget.petId);
      //mensagem para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Consulta Deletada com Sucesso"))
        );
        setState(() {
          
        });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e"))
        );
    }
  }
}