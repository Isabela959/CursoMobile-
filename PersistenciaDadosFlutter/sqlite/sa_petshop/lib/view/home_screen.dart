import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/view/cadastro_pet_screen.dart';

import '../models/pet_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final PetController _controllerPet = PetController();
  List<Pet> _pets = [];
  bool _isLoading = true;

  @override //carrega o método antes de construir a tela. se tiver dados no banco já buscar as info
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    setState(() {
      _isLoading = true;
    });
    _pets = [];
    try {
      _pets = await _controllerPet.readPets();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao Carregar os Dados $e")));
    } finally { //execução obrigatória independente  do resultado
      setState(() {
        _isLoading = false;
      });
    }
  }

  
  //build da Tela
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Meus Pets - Cliente"),),
      body: _isLoading
        ? Center(child: CircularProgressIndicator(),)
        : Padding(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: _pets.length,
            itemBuilder: (context,index){
              final pet = _pets[index];
              return ListTile(
                title: Text("${pet.nome} - ${pet.raca}"),
                subtitle: Text("${pet.nomeDono} - ${pet.telefoneDono}"),
                //onTap: () => , //página de detalhes do PET
              );
            }),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: 
        (context)=> CadastroPetScreen())),
        tooltip: "Adicionar Novo Pet",
        child: Icon(Icons.add),
        ),
    );
  }
}
