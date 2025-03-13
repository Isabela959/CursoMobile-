import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext contex){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Exemplo Widgets Exibição"),),
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
              textAlign: TextAlign.right,),
              Image.network('https://storage.googleapis.com/cms-storage-bucket/9abb63d8732b978c7ea1.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,),
              Image.asset("assets/img/einstein.jpg",
              width: 450,
              height: 450,
              fit: BoxFit.cover,),
              Icon(Icons.star,
              size: 100,
              color: Colors.amberAccent,)
            ],
          ),
        ),
      ),
    );
  }
}