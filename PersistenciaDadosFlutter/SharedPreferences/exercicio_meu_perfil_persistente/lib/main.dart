import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserChoicePage(),
  ));
}

class UserChoicePage extends StatefulWidget{
  @override
  _UserChoicePage createState() => _UserChoicePage();
}

class _UserChoicePage extends State<UserChoicePage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();
  TextEditingController _corFundoController = TextEditingController();
  bool _mudarFundo = false;

  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  void _carregarPreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _mudarFundo = prefs.getBool("mudarFundo") ?? false;
    });
  }

  void mudarFundoTela() async {
    setState(() {
      _mudarFundo = ! _mudarFundo;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("mudarFundo", _mudarFundo);
    _carregarPreferencias();
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personalizar Perfil"),),
        body: Padding(
          padding: EdgeInsets.all(15)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: "Nome"),
              ),
              TextField(
                controller: _idadeController,
                decoration: InputDecoration(labelText: "Idade"),
              ),
              DropdownButton(
                items: <String>[
                  'Azul',
                  'Roxo'
                  'Rosa',
                  'Verde-Água'
                ], 
                onChanged: onChanged)
            ],
          ),
          ),
    )
  }


}