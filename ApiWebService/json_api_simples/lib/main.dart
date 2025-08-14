import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: TarefasPage()));
}

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TarefasPageState();
  }
}

class _TarefasPageState extends State<TarefasPage> {
  //atributos
  //Lista de tarefas<Map>
  List<Map<String, dynamic>> _tarefas = [];
  //controlador para o TextField
  final TextEditingController _tarefaController = TextEditingController();
  // endereço da API
  final String baseUrl = "http://10.109.197.19:3012/tarefas";

  // métodos
  @override
  void initstate() {
    super.initState();
    _carregarTarefas();
  }

  void _carregarTarefas() async {
    try {
      // fazer a conexão via HTTP (biblioteca http)
      final response = await http.get(
        Uri.parse(baseUrl), // converter Str -> endereço URL
      ); // converter String para endereço URL
      if (response.statusCode == 200) {
        List<dynamic> dados = json.decode(
          response.body,
        ); // converti de JSON -> dart
        setState(() {
          _tarefas = dados
              .map((item) => Map<String, dynamic>.from(item))
              .toList(); // mais correto
          // _tarefas = dados.cast<Map<String, dynamic>>(); // jeito mais rápido
          //_tarefas = List<Map<String, dynamic>>.from(dados); // jeito mais direto
        });
      }
    } catch (e) {
      print("Erro ao carregar API: $e");
    }
  }

  void _adicionarTarefa(String titulo) async {
    try {
      //cria um objeto -> tarefa
      final tarefa = {"titulo": titulo, "concluida": false};
      // faz o post http
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(tarefa), //converte dart -> JSON
      );
      //verifica se deu certo
      if (response.statusCode == 201) {
        setState(() {
          _tarefaController.clear();
          _carregarTarefas();
        });
      }
    } catch (e) {
      print("Erro ao adicionar tarefa: $e");
    }
  }

  //remover tarefas
  void _removerTarefa(String id) async {
    try {
      //solicitação http -> delete (URL + ID)
      final response = await http.delete(Uri.parse("$baseUrl/$id"));
      if (response == 200) {
        setState(() {
          _carregarTarefas();
        });
      }
    } catch (e) {
      print("Erro ao deletar Tarefa $e");
    }
  }

  //atualizar tarefa

  void _atualizarTarefa(bool concluida, String id) async {
    try {
      // solicitação http -> patch
    final response = await http.patch(Uri.parse("$baseUrl/$id"));
    if _tarefa
    } catch (e) {
      print("Erro ao atualizar tarefa: $e");
    }
  }

  //build Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas via API")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(
                labelText: "Nova Tarefa",
                border: OutlineInputBorder(),
              ),
              onSubmitted: _adicionarTarefa,
            ),
            SizedBox(height: 10),
            Expanded(
              // Conseguir Scrollar a tela
              //operador ternário
              child: _tarefas.isEmpty
                  ? Center(child: Text("Nenhuma Tarefa Cadastrada"))
                  : ListView.builder(
                      itemCount: _tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = _tarefas[index];
                        return ListTile(
                          //leading para criar um checkbox(atualizar)
                          title: Text(tarefa["titulo"]),
                          subtitle: Text(
                            tarefa["concluida"] ? "Concluída" : "Pendente",
                          ),
                          trailing: IconButton(
                            onPressed: () => _removerTarefa(tarefa["id"]),
                            icon: Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
