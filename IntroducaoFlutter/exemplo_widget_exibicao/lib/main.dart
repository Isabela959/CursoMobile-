import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build(BuildContext contex){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("Texto de Exemplo", 
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo
              ),),
              Text("Flutter é Incrível", 
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
                letterSpacing: 2
              ),
              textAlign: ,)
            ],
          ),
        ),
      ),
    );
  }
}