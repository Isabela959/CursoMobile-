import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sa02_geo_cam/models/Image.dart';

class ImageController {
  // método para pegar a imagem no dispositivo,
  // pegar a geolocalização, pegar a data e a partir da
  // geolocalização determinar a cidade onde a foto foi tirada
  // vai retornar um objeto da classe Image (model)

  Future<Image> imageWithLocation() async {
    final _picker = ImagePicker();
    String imagePath = "";
    String _apikey = "MinhaChaveAPI";
    String cityName = "";

    //verificar se a geolocalização está ativada
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception("Serviço de Localização Desabilitado");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão Negada");
      }
    }
    //permissão liberada pegar localização
    Position position = await Geolocator.getCurrentPosition();
    //pegar a imagem
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile == null) {
      throw Exception("Imagem não adicionada");
    }
    imagePath = File(pickedFile.path).toString();
    //conecta com API para buscar informações da localização a partir da latitude e longitude
    final result = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?apiid=$_apikey&lat=${position.latitude}&lon=${position.longitude}",
      ),
    );
    // verificar o result
    if (result.statusCode != 200) {
      throw Exception("Localização Não Encontrada");
    }
    Map<String, dynamic> data = jsonDecode(result.body);
    cityName = data["name"];
    // Criar o OBJ
    Image image = Image(
      location: cityName,
      dateTime: DateTime.now().toString(), //converte para data local br
      imagePath: imagePath,
    );
    return image;
  }
}
