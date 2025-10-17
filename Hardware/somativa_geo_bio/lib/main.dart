import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:somativa_geo_bio/views/home_view.dart';
import 'package:somativa_geo_bio/views/login_view.dart';

void main() async {
  //garante o carregamento dos widgets
  WidgetsFlutterBinding.ensureInitialized();

  //conectar com o Firebase
  await Firebase.initializeApp();
  
  runApp(
    MaterialApp(
      title: "Registro de Ponto",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: AuthStream(),
    ),
  );
}

class AuthStream extends StatefulWidget {
  const AuthStream({super.key});

  @override
  State<AuthStream> createState() => _AuthStreamState();
}

class _AuthStreamState extends State<AuthStream> {
  @override
  Widget build(BuildContext context) {
    // StreamBuilder -> toma uma decisão com base nos dados que estão sendo armazenados na memória
    return StreamBuilder<User?>(
      // permite usuário null
      stream: FirebaseAuth.instance
          .authStateChanges(), // identifica a mudança de status da auth (verifica se tem um usuário logado)
      builder: (context, snapshot) {
        // snapshot -> memória instantânea
        // se tiver logado, vai para a tela de Favoritos
        if (snapshot.hasData) {
          // verifica se o snapshot tem algum dado
          return HomeView();
        } //caso não estiver logado
        return LoginView();
      },
    );
  }
}