import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TarefasView extends StatefulWidget {
  const TarefasView({super.key});

  @override
  State<TarefasView> createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  //atributos
  final _db = FirebaseFirestore
      .instance; // controlador do Firebase (envia as tarefas para o BD)
  final User? _user =
      FirebaseAuth.instance.currentUser; // pega o usuário logado
  final _tarefasField = TextEditingController(); //epgar título da tarefa

  //métodos

  //adicionar tarefa
  void _addTarefa() async {
    if (_tarefasField.text.trim().isEmpty)
      return; // não continua se campo de tarefa for nulo
    //adicionar a tarefa no banco do firestore
    try {
      await _db
          .collection("usuarios")
          .doc(_user!.uid)
          .collection("tarefas")
          .add({
            "titulo": _tarefasField.text.trim(),
            "concluida": false,
            "dataCriacao": Timestamp.now(), // carimbo de data e hora
          });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao Adicionar Tarefas $e")));
    }
  }

  //atualizar tarefa
  void _atualizarTarefa(String tarefaId, bool concluida) async {
    try {
      await _db
          .collection("usuarios")
          .doc(_user!.uid)
          .collection("tarefas")
          .doc(tarefaId)
          .update({"concluida": concluida});
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao Atualizar Tarefa $e")));
    }
  }

  //deletar tarefa
  void _deletarTarefa(String tarefaId) async {
    try {
      await _db
          .collection("usuarios")
          .doc(_user!.uid)
          .collection("tarefas")
          .doc(tarefaId)
          .delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao Deletar tarefa $e")),
      );
    }
  }

  //build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MInhas Tarefas"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      //body das tarefas
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tarefasField,
              decoration: InputDecoration(
                labelText: "Nova Tarefa",
                border: OutlineInputBorder(),
                suffix: IconButton(
                  onPressed: _addTarefa,
                  icon: Icon(Icons.add),
                ),
              ),
            ),
            SizedBox(height: 20),
            //constuir a lista de tarefas StreamBuilder
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db
                    .collection("usuarios")
                    .doc(_user?.uid)
                    .collection("tarefas")
                    .orderBy("dataCriacao", descending: true)
                    .snapshots(), // lê a modificação da lista de tarefas
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("Nenhuma Tarefa Encontrada"));
                  }
                  final tarefas = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: tarefas.length,
                    itemBuilder: (context, index) {
                      final tarefa = tarefas[index];
                      //convete Texto/Json em Map<String, dynamic>
                      final tarefaMap = tarefa.data() as Map<String, dynamic>;
                      //ajustar a boolean
                      bool concluida = tarefaMap["concluida"] ?? false;
                      return ListTile(
                        //para cada item da lista adicione um ListTile
                        title: Text(tarefaMap["titulo"]),
                        leading: Checkbox(
                          value: concluida,
                          onChanged: (value)=> _atualizarTarefa(tarefa.id, value ?? false)),
                        trailing: IconButton(
                          onPressed: ()=> _deletarTarefa(tarefa.id), // passar o id da tarefa
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      );
                    },
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
