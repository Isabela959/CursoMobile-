import 'package:flutter/material.dart';
import 'package:somativa_geo_bio/controllers/ponto_controller.dart';
import '../models/point.dart';
import 'package:intl/intl.dart';

class HistoricoView extends StatefulWidget {
  const HistoricoView({super.key});

  @override
  State<HistoricoView> createState() => _HistoricoViewState();
}

class _HistoricoViewState extends State<HistoricoView> {
  final PointController _pointController = PointController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Histórico de Pontos")),
      body: StreamBuilder<List<Point>>(
        stream: _pointController.getPoints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum ponto registrado ainda"));
          }

          final pontos = snapshot.data!;

          return ListView.builder(
            itemCount: pontos.length,
            itemBuilder: (context, index) {
              final ponto = pontos[index];
              final formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(ponto.dataHora);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text("Data/Hora: $formattedDate"),
                  subtitle: Text("Latitude: ${ponto.latitude}\nLongitude: ${ponto.longitude}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
