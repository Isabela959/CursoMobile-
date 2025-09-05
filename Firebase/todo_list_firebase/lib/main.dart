//S incroniza com o firebase enquanto compila o build o aplicativo
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/firebase_options.dart';
import 'package:todo_list_firebase/views/auth_view.dart';

void main() async {
  //garantir a inicialização dos binding
  WidgetsFlutterBinding.ensureInitialized();
  //inicializa o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    title: "Lista de Tarefas",
    home: AuthView(),
  ));
}
