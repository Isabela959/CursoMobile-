// Criar uma tela de perfil persistente, que muda de cor ao selecionar salvar a cor

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() { // função principal que faz rodar a tela inicial
  runApp(MaterialApp( //widget raiz (principal - Elementos Visual)
  home: PerfilPage(),
  //configurações de rota
  //routes: ,
  //configurações de tema
  ));
}

class PerfilPage extends StatefulWidget{ //Tela Dinâmica
  // chamar o createState
  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
// atributos
TextEditingController _nomeController = TextEditingController();
TextEditingController _idadeController = TextEditingController();

String? _nome; //permite a variável nula inicialmente
String? _idade; 

String? _cor;
Color _corFundo = Colors.white; //cor inicial do app

//criar uma lista sem ordem. Chamar a chave para acessar seu valor
Map<String, Color> coresDisponiveis = {
  "Azul": Colors.blueAccent,
  "Rosa": Colors.pinkAccent,
  "Roxo": Colors.purple,
  "Verde": Colors.blueGrey,
  "Preto": Colors.black,
};

//métodos
@override
void initState() { //método para carregar as informações antes de buildar}
super.initState();
_carregarPreferencias();
}

_carregarPreferencias() async { // método assíncrono (método que irá conectar com uma base de dados)
  //conectar com o sharedPreferences
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  setState(() {
  _nome = _prefs.getString("nome");
  _idade = _prefs.getString("idade");
  _cor = _prefs.getString("cor");
  if (_cor != null) {
    _corFundo = coresDisponiveis[_cor!]!; // cor não pode ser nula
  }
});
}

_salvarPreferencias() async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _nome = _nomeController.text.trim();
  _idade = _idadeController.text.trim();
  _corFundo = coresDisponiveis[_cor!]!;
  await _prefs.setString("nome", _nome ?? "");
  await _prefs.setString("idade", _idade ?? "");
  await _prefs.setString("cor", _cor ?? "Branco");
  setState(() {
    
  });
}

// Elemento build é obrigatório para o State
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: _corFundo,
      appBar: AppBar(title: Text("Meu Perfil", 
      style: TextStyle(color: _cor=="Branco"? Colors.black : Colors.white),),
      backgroundColor: _corFundo,),
      body: Padding(padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: "Nome"),
          ),
          TextField(
            controller: _idadeController,
            decoration: InputDecoration(labelText: "Idade"),
          ),
          SizedBox(height: 16,),
          DropdownButtonFormField(
            value: _cor, 
            decoration: InputDecoration(labelText: "Cor Favorita"),
            items: coresDisponiveis.keys.map(
              (cor){
                return DropdownMenuItem(
                  value: cor,
                  child: Text(cor));
              }
            ).toList(),
            onChanged: (valor){
              setState(() {
                _cor = valor;
              });
            }),
            SizedBox(height: 16,),
            ElevatedButton(onPressed: _salvarPreferencias, child: Text("Salvar Perfil")),
            SizedBox(height: 16,),
            Divider(),
            Text("Dados do Usuário:"),
            //usar um if dentro do widget
            if(_nome !=null)
              Text("Nome: $_nome", style: TextStyle(color: _cor=="Branco"? Colors.black : Colors.white)),
            if(_idade !=null)
              Text("Idade: $_idade", style: TextStyle(color: _cor=="Branco"? Colors.black : Colors.white)),
        ],
      ),),
    );
  }
}