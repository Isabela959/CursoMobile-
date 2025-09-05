import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/login_view.dart';
import 'package:todo_list_firebase/views/tarefas_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) { //usa os dados do cache para decidir
        if (snapshot.hasData) { // se tiver dados, vai para Tarefas
          return TarefasView();
        } // se não tiver dados no cache vai para login
        return LoginView();
      },
    );
  }
}
