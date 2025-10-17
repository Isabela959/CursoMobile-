import 'package:flutter/material.dart';
import 'package:somativa_geo_bio/views/home_view.dart';
import '../controllers/auth_controller.dart';
import 'registro_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController _authController = AuthController();
  final _nifField = TextEditingController();
  final _senhaField = TextEditingController();
  bool _ocultarSenha = true;

  // Login por NIF e senha
  void _login() async {
    try {
      await _authController.loginUsuario(
        nif: _nifField.text.trim(),
        senha: _senhaField.text,
      );
      print("Login Feito com Sucesso");
      // Navegar pra tela inicial (pode criar HomeView depois)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Falha ao fazer login: $e")));
    }
  }

  // Login por biometria
  void _loginBiometria() async {
    bool autenticado = await _authController.autenticarBiometria();
    if (autenticado) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha na autenticação biométrica")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: const Color.fromARGB(255, 0, 0, 0),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text(
                    "Entrar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _loginBiometria,
                  icon: const Icon(Icons.fingerprint),
                  label: const Text("Entrar com Biometria"),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistroView(),
                    ),
                  ),
                  child: const Text("Não tem uma conta? Registre-se aqui"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
