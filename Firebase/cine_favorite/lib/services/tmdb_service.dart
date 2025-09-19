// meu serviço de conexão com a API

import 'dart:convert';

import 'package:http/http.dart' as http;

class TmdbService {
  //colocar os dados da API
  static const String _apiKey = "1fa5c2d59029fd1c438cc35713720604";
  static const String _baseURL = "https://api.themoviedb.org/3";
  static const String _idioma = "pt-BR";

  // método para buscar filme com base no texto

  static Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    // converter String em URL
    final apiUrl = Uri.parse("$_baseURL/search/movie?api_key=$_apiKey&query=$query&language=$_idioma");
    //http.get
    final response = await http.get(apiUrl);

    //se a rsesposta form ok ==200
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data["results"]);
    } else {
      //caso contrário cria uma exception
      throw Exception("Falha ao Carregar Filmes da API");
    }
  }

  //método de busca de filme pelo ID
  
}
