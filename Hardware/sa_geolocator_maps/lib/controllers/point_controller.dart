import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sa_geolocator_maps/models/location_points.dart';

class PointController {
  final DateFormat _formatar = DateFormat("dd/MM/yyyy - HH:mm:ss");

  //método para pegar a geolocalização do ponto
  Future<LocationPoints> getcurrentLocation() async {
    // solicitar a localização atual do dispositivo
    //liberar a permissões
    // verificar se o aplicativo possui o serviço de geolocalização habilitado
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception("Sem Acesso ao GPS");
    }
    LocationPermission permission;
    //verificar a permissão de uso do gps
    permission = await Geolocator.checkPermission();
    // por padrão, todo novo aplicativo instalado não possui permissão
    if (permission == LocationPermission.denied) {
      // solicitar o acesso a geolocalização
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão Negada de Acesso ao GPS");
      }
    }
    // o acesso foi liberado
    Position position = await Geolocator.getCurrentPosition();
    //pegar a data e a hora ( e formata no padrão BR)
    String dataHora = _formatar.format(DateTime.now());
    // criar um OBJ do Model
    LocationPoints posicaoAtual = LocationPoints(
      latitude: position.latitude,
      longitude: position.longitude,
      timeStamp: dataHora,
    );

    //devolve o obj
    return posicaoAtual;
  }
}
