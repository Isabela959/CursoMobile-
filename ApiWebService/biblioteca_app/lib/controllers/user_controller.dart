// classe para o controller dos usuário
// transição do VIEW para o MODEL
// recebe as requisições da VIEW e chama os métodos do MODEL

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
    return list.map((item) => Usuario.fromJson(item)).toList();
  }

  //Get de um único Usuário
  Future<Usuario> fetchOne(String id) async {
    final usuario = await ApiService.getOne("usuarios", id);
    return Usuario.fromJson(usuario);
  }

  //post -> criar um novo usuário
  Future<Usuario> create(Usuario user) async {
    final created = await ApiService.post("usuarios", user.toJson());
    return Usuario.fromJson(created);
  }

  //put -> alterar um usuário
  Future<Usuario> update(Usuario user) async {
    final updated = await ApiService.put("usuarios", user.toJson(), user.id!);
    return Usuario.fromJson(updated);
  }

  //delete -> excluir um usuário
  Future<void> delete(String id) async {
    await ApiService.delete("usuarios", id);
  }
}
