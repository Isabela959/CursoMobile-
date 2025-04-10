// imports do widget MaterialApp e das outras telas
import 'package:flutter/material.dart';
import 'view/tela_infografico_view.dart';
import 'view/tela_inicial_view.dart';
import 'view/tela_tarefas_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // tirar a faixa de debug
      initialRoute: "/", // definir rota inicial
      routes: {
        "/": (context) => TelaInicial(), // atribui a rota "/" para a tela inicial
        "/tarefas": (context) => TelaTarefas(), // atribui a rota "/tarefas" para a tela de tarefas
        "/infografico": (context) => TelaInfografico(), // atribui a rota "/infografico" para a tela do dashboard
      },
    ),
  );
}
