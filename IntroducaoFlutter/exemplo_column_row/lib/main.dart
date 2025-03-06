import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Exemplo Columns(Column) linhas(row)')),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Linha 1"),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("coluna 1"),
            Text("coluna 2"),
          ],
      ),
      Text("Linha 3")
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Icon(Icons.person), 
          )
        ],
      )
      ],
        ),
        ),
        );
  }
}
