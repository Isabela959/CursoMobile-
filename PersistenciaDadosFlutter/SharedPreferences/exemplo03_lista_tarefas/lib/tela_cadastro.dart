// tela simples 

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaCadastro extends StatelessWidget{
  //atributos
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _confirmacaoSenhaController = TextEditingController();

  //métodos
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Cadastro"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            TextField(
              controller: _confirmacaoSenhaController,
              decoration: InputDecoration(labelText: "Confirmar Senha"),
              obscureText: true,
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () => _cadastrarUsuario(context), 
              child: Text("Cadastrar"))
          ],
        ),
        ),
    );
  }

  _cadastrarUsuario(BuildContext context) async {
    String _nome = _nomeController.text.trim();
    String _senha = _senhaController.text.trim();
    String _confirmarSenha = _confirmacaoSenhaController.text.trim();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String nomeExistente = _prefs.getString(_nome) ?? "";
    if (_nome.isEmpty || _senha.isEmpty || _confirmarSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Preencha Todos od Campos")));
    } else if (nomeExistente.isNotEmpty){ //veriica se o usuário já existe
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Usuário já Cadastrado")));
    } else if (_senha != _confirmarSenha){ //verifica se as senhas são compatíves
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("As senhas não podem ser diferentes!")));
    } else {
      _prefs.setString(_nome,_senha); //salva no cache a senha para o usuário
      Navigator.pushNamed(context, "/"); //navega para a tela de login
    }
  }
}