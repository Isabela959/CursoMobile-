import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Classe principal do aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddTaskScreen(),
    );
  }
}

// Classe que representa a tela de adicionar tarefa
class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Tarefa"),
        backgroundColor: Colors.grey[300],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Text("Configurações"),
            Text("Notificações"),
            Text("Temas"),
            Text("Perfil"),
            Text("Ajuda"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Título da Tarefa",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: "Descrição",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text("Adicionar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[300],
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.check), onPressed: () {}),
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.purple[300],
              child: Icon(Icons.add),
            ),
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            IconButton(icon: Icon(Icons.light_mode), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
