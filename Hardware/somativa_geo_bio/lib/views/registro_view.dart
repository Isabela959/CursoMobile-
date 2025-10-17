import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final AuthController _authController = AuthController();
  final _nomeField = TextEditingController();
  final _nifField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confirmarSenhaField = TextEditingController();
  bool _ocultarSenha = true;
  bool _ocultarConfirmarSenha = true;

  // Método para registrar usuário
  void _registrar() async {
    if (_senhaField.text != _confirmarSenhaField.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("As senhas devem ser iguais")),
      );
      return;
    }

    try {
      await _authController.cadastrarUsuario(
        nome: _nomeField.text.trim(),
        nif: _nifField.text.trim(),
        senha: _senhaField.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuário registrado com sucesso!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao registrar: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeField,
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: _nifField,
              decoration: const InputDecoration(labelText: "NIF"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                suffix: IconButton(
                  onPressed: () => setState(() {
                    _ocultarSenha = !_ocultarSenha;
                  }),
                  icon: Icon(
                    _ocultarSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _ocultarSenha,
            ),
            TextField(
              controller: _confirmarSenhaField,
              decoration: InputDecoration(
                labelText: "Confirmar Senha",
                suffix: IconButton(
                  onPressed: () => setState(() {
                    _ocultarConfirmarSenha = !_ocultarConfirmarSenha;
                  }),
                  icon: Icon(
                    _ocultarConfirmarSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _ocultarConfirmarSenha,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registrar,
              child: const Text("Registrar"),
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              ),
              child: const Text("Já tem uma conta? Faça login aqui"),
            ),
          ],
        ),
      ),
    );
  }
}
