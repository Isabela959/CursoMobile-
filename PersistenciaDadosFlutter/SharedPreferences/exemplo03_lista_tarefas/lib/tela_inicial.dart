//Tela Dinâmica que Modificar o status
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicial extends StatefulWidget{
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial>{
  //atributos
  TextEditingController _nomeController = TextEditingController(); // Controlador do Campo de Texto (TextField)
  TextEditingController _senhaController = TextEditingController();
  String _nome = "";
  String _senha = "";
  bool _darkMode = false;
  bool _logado = false;

  //métodos
  //carregar informações no inicio 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarPreferencias(); // carregar as preferencias salvas
    if (_logado) {
      Navigator.pushNamed(context, "/tarefas");
    }
  }

  _carregarPreferencias() async{
    //conectar com o shared Preferences - instalar a dependencia
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {//mudança de estado da página
      _nome = _prefs.getString("nome") ?? ""; // carrega "" caso não tenha nenhum armazenamento
      _senha = _prefs.getString(_nome) ?? ""; //carrega "" caso não tenha nenhuma
      _darkMode = _prefs.getBool("darkMode") ?? false;
      _logado = _prefs.getBool("logado") ?? false;
    });
  }

  _trocarTema() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = !_darkMode; //inverte o valor da bool
      _prefs.setBool("darkMode", _darkMode); // salva a preferencia na Memoria(cache)
    });

  }

  _logar() async{
    _nome = _nomeController.text.trim();
    _senha = _senhaController.text.trim();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_nome.isEmpty || _senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Preencha todos os Campos"))); 
    }else if(_prefs.getString(_nome) == _senha){
      _prefs.setString("nome", _nome); //salva o nome no cache
      _prefs.setBool("logado", true); // salva o login no cache
      _nomeController.clear();
      _senhaController.clear();
      Navigator.pushNamed(context, "/tarefas"); //navega para tela de Tarefas
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nome e/ou Senha Incorreta"))); 
    }

  }

  //build
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark(): ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bem-Vindo ${_nome=="" ? "Visitante" : _nome}"),
          actions: [
            IconButton(
              onPressed: _trocarTema, 
              icon: Icon(_darkMode ? Icons.light_mode : Icons.dark_mode))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Fazer Login", style: TextStyle(fontSize: 20),),
              SizedBox(height: 20,),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: "Nome"),
              ),
              TextField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: "Senha"),
                obscureText: true,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _logar, 
                child: Text("Logar")),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/cadastro"), 
                child: Text("Cadastrar"))
            ],
          ),
          ),
      ),
    );
  }

}