// classe para o controller dos usuário

import 'package:biblioteca_app/models/usuario.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UsuarioController {
  //métodos
  //Get do usuário
  Future<List<Usuario>> fetchAll() async {
    //pega a lista de usuário no formato List<dynamic>
    final list = await ApiService.getList("usuarios?_sort=name");
    // retornar a lista de usuários convertidos
    // map = percorre a lista e permite fazer uma ação em cada item
    return list.map((item)=>Usuario.fromJson(item)).toList()
  }
  //Get de um único Usuário
  Future<Usuario> fetchOne(String id) async{
    final usuario = await ApiService.getOne("usuario", id);
    return Usuario.fromJson(usuario);
  }
  //post -> criar um novo usuário
  //put -> alterar um usuário
  //delete -> excluir um usuário
}
