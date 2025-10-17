import 'package:flutter/material.dart';
import 'package:somativa_geo_bio/controllers/ponto_controller.dart';
import '../controllers/auth_controller.dart';
import '../models/point.dart';
import 'login_view.dart';
import 'historico_view.dart';
import 'package:uuid/uuid.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthController _authController = AuthController();
  final PointController _pointController = PointController();
  bool _registrado = false;

  // Latitude e longitude pré-definidas do local de trabalho
  final double _latitudeEmpresa = -22.5645;
  final double _longitudeEmpresa = -47.4015;

  void _registrarPonto() async {
    if (_pointController.currentUser == null) return;

    final point = Point(
      id: const Uuid().v4(),
      userId: _pointController.currentUser!.uid,
      latitude: _latitudeEmpresa,
      longitude: _longitudeEmpresa,
      dataHora: DateTime.now(),
    );

    await _pointController.addPoint(point);

    setState(() {
      _registrado = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ponto registrado com sucesso!")),
    );
  }

  void _logout() async {
    await _authController.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nomeUsuario = _authController.currentUser?.displayName ?? "Usuário";

    return Scaffold(
      appBar: AppBar(
        title: Text("Bem-vindo, $nomeUsuario"),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registrado ? null : _registrarPonto,
              child: Text(_registrado ? "Ponto Registrado" : "Registrar Ponto"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoricoView()),
                );
              },
              child: const Text("Ver Histórico de Pontos"),
            ),
            const SizedBox(height: 20),
            Text("Local do registro:"),
            Text("Latitude: $_latitudeEmpresa"),
            Text("Longitude: $_longitudeEmpresa"),
          ],
        ),
      ),
    );
  }
}
