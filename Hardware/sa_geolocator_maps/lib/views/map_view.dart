import 'package:flutter/material.dart';
import 'package:sa_geolocator_maps/controllers/map_controller.dart';
import 'package:sa_geolocator_maps/models/location_points.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  //atributos
  List<LocationPoints> listaPosicoes = [];
  final _mapController = MapController();

  bool _isLoading = false;
  String? _error;

  // método para adicionar o ponto no mapa
  void _adicionarPonto() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      //pegar localização atual
      LocationPoints novaMarcacao = await _mapController.getcurrentLocation();
      listaPosicoes.add(novaMarcacao);
    } catch (e) {
      _error = e.toString();
      //mostro o erro
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_error!)));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // adicionar pontos no mapa (vai prcisar da biblioteca flutter_map)
      appBar: AppBar(
        title: Text("Mapa de localização"),
        actions: [
          IconButton(
            onPressed: _adicionarPonto, 
            icon: _isLoading
            ? CircularProgressIndicator() 
            : Icon(Icons.add_location))
        ],
      ),
    );
  }
}
