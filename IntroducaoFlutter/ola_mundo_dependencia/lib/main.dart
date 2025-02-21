import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// flutter create --platforms=android --empty ola_mundo_dependências

void main() { //método necessário para rodar aplicação
  MyApp();
}

class MyApp extends StatelessWidget { //classe inicial
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //material app (material base de desenvolvimento)
      home: Scaffold( //página inicial usando uma tela padrão
        appBar: AppBar(title: Text("App Olá Mundo")), 
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Olá, Mundo!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            },
            child: Text("Mostrar Mensagem"),
          ),
        ),
      ),
    );
  }
}

