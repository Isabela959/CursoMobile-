import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sa_geolocator_maps/controllers/point_controller.dart';
import 'package:sa_geolocator_maps/models/location_points.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  //atributos
  List<LocationPoints> listaPosicoes = [];
  final _pointController = PointController();

  bool _isLoading = false;
  String? _error;

  //controlador para o flutter_map
  final _flutterMapController = MapController();

  // método para adicionar o ponto no mapa
  void _adicionarPonto() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      //pegar localização atual
      LocationPoints novaMarcacao = await _pointController.getcurrentLocation();
      listaPosicoes.add(novaMarcacao);
      // direcionar meu map para o ponto adicionado
      _flutterMapController.move(
        LatLng(novaMarcacao.latitude, novaMarcacao.longitude), 12);
    } catch (e) {
      _error = e.toString();
      //mostra o erro
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
                : Icon(Icons.add_location_alt),
          ),
        ],
      ),
      // mapa na tela
      // flutter_map
      body: FlutterMap( // uma pilha de camadas
      mapController: _flutterMapController,
      options: MapOptions(
        initialCenter: LatLng(-22.3353, -47.2406),
        initialZoom: 12,
      ),
        children: [
          // camada do mapa
          TileLayer(
            // eixo z, x & y (para cima, baixo e dentro/fora)
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: "com.example.sa_geolocator_maps",
          ),
          // Camada de Marcação
          MarkerLayer(
            markers: listaPosicoes.map((ponto){
              return Marker(
                point: LatLng(ponto.latitude, ponto.longitude), 
                width: 50,
                height: 50,
                child: Icon(Icons.location_on, color: Colors.red, size: 35,));
            }).toList())
        ]),
    );
  }
}
