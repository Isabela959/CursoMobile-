// classe de ajuda para conexão com API

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  // base url para conexão
  static const _baseUrl = "http://10.109.197.8:3012";

  //métodos Static significa que não precisa criar um objeto para usar o método
  // métodos da classe e não do obj
  //GET -> Listar todos os Recursos
  static Future<List<dynamic>> getList(String path) async {
    final res = await http.get(Uri.parse("$_baseUrl/$path"));
    if (res.statusCode == 200)
      return json.decode(res.body); // se deu certo interrompe o método
    // se não deu certo -> gerar um erro
    throw Exception(
      "Falha ao Carregar List de $path",
    ); // deve ser tratado em um try catch
  }

  //GET -> Listar apenas um Recurso
  static Future<Map<String, dynamic>> getOne(String path, String id) async {
    final res = await http.get(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode == 200) return json.decode(res.body);
    // se dar errado
    throw Exception("Erro ao Carregar Recurso de $path");
  }

  //POST -> adicionar um Recurso
  static Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final res = await http.post(
      //URL/header/body
      Uri.parse("$_baseUrl/$path"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    if (res.statusCode == 201)
      return json.decode(res.body); //retorna o obj om ID
    throw Exception("Falha ao Criar Recurso em $path");
  }

  //PUT -> Atualizar um Recurso
  static Future<Map<String, dynamic>> put(
    String path,
    Map<String, dynamic> body,
    String id,
  ) async {
    final res = await http.put(
      //URL/Header/Body
      Uri.parse("$_baseUrl/$path/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    if (res.statusCode == 200)
      return json.decode(res.body); //retorna o obj com ID
    throw Exception("Falha ao Atualizar Recurso em $path");
  }

  //DELETE -> Deletar um Recurso
  static delete(String path, String id) async {
    final res = await http.delete(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode != 200)
      throw Exception("Falha ao Deletar Recurso de $path");
  }
}
