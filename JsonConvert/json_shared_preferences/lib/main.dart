import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool temaEscuro = false;
  String nomeUsuario = "";

  @override
  void initState() {
    super.initState();
    carregarPeferencias();
  }

  void carregarPeferencias() async {
    // conecta com as SharedPrefences e busca as informações armazenadas
    final prefs = await SharedPreferences.getInstance();
    // recupera as informações do sharedPref e armazena como String (Json)
    String? jsonString = prefs.getString('config');
    if (jsonString != null) {
      // Transformo Json m MAP - decode
      Map<String, dynamic> config = json.decode(jsonString);
      setState(() {
        //pega as informações de acordo com a chave armazenada
        temaEscuro = config['temaEscuro'] ?? false; // caso vazio, é falso
        nomeUsuario = config['nome'] ?? ""; // caso vazio, é vazio
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de Configurações",
      //operador ternário
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: ConfigPage(),
    );
  }
}
