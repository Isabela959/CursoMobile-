import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/registro_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // atributos
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // controlador das ações de autenticação do usuário
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  bool _ocultarSenha = true;

  // método para fazer login
  void _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        // chama o método de autenticação do controller por email e senha
        email: _emailField.text.trim(),
        password: _senhaField.text,
        //Verifica se conseguiu autenticação no firebase (muda o status do usuário)
        //direciona automaticamente  para a tela de tarefas (AuthView)
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Falha ao Fazer Login: $e")));
    }
  }

  // build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailField,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              //criar o olhinho para ver senha
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                suffix: IconButton(
                  onPressed: ()=> setState(() {
                    _ocultarSenha = !_ocultarSenha;
                  }), 
                  icon: Icon(_ocultarSenha ? Icons.visibility : Icons.visibility_off))),
              obscureText: _ocultarSenha, //oculta a senha quando digitada
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _signIn, child: Text("Login")),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistroView()),
              ),
              child: Text("Não tem uma conta? Registre-se Aqui"),
            ),
          ],
        ),
      ),
    );
  }
}
