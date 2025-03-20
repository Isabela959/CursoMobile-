import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListaTarefas()
  ));
}

class ListaTarefas extends StatefulWidget{
  @override
  _ListaTarefasState createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas>{
  final TextEditingController _tarefaController = TextEditingController();
  List<Map<String,dynamic>> _tarefas =[];

  void _adicionarTarefas(){
    if (_tarefaController.text.trim().isNotEmpty) {
      setState(() {
        _tarefas.add({"titulo": _tarefaController.text, "concluida": false});
        _tarefaController.clear();
      });
    }
  }

  void _removerTarefa(){
    setState(() {
      _tarefas.removeWhere((tarefa) => tarefa['concluida']);
    });
  }

  // construir a estrutura visual (widgets)
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Lista de Tarefas"),),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _tarefaController,
            decoration: InputDecoration(labelText: "Digite uma Tarefa"),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: _adicionarTarefas, 
            child: Text("Adicionar Tarefa")),
            Expanded(
            child: ListView.builder(
            itemCount: _tarefas.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                _tarefas[index]["titulo"],
                style: TextStyle(
                  decoration: _tarefas[index]["concluida"] ? TextDecoration.lineThrough: null,
                ),
              ),
              leading: Checkbox(
                value: _tarefas[index]["concluida"], 
                onChanged: (bool? valor){
                  setState(() {
                    _tarefas[index]["concluida"]=valor!;
                  });
                }),
            )),
            )
        ],
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: _removerTarefa,
        child: Icon(Icons.recycling),),
        
  );
}
