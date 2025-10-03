// serviço de conexão com a API de Clima

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ClimaService {
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  static const String apiKey = "90290436d34bb91b4d852afe49197129";

  static Future<Map<String, dynamic>> getCityWeatherByPosition(Position position) async{
    final response = await http.get(Uri.parse(
      "$baseUrl?appid=$apiKey&lat=${position.latitude}&lon=${position.longitude}"
    ));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("Localização Não Encontrada");
    }
  }
}
