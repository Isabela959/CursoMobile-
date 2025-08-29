import 'package:biblioteca_app/models/livro.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LivroController {
  //métodos
  //Get do Livro
  Future<List<Livro>> fetchAll() async {
    final list = await ApiService.getList("livros?_sort=titulo");
    return list.map((item) => Livro.fromJson(item)).toList();
  }

  //Get de um único livro
  Future<Livro> fetchOne(String id) async {
    final livro = await ApiService.getOne("livros", id);
    return Livro.fromJson(livro);
  }

  //Post -> Criar um novo livro
  Future<Livro> create(Livro livro) async {
    final created = await ApiService.post("livros", livro.toJson());
    return Livro.fromJson(created);
  }

  //Put -> Alterar um Livro
  Future<Livro> update(Livro livro) async {
    final updated = await ApiService.put("livros", livro.toJson(), livro.id!);
    return Livro.fromJson(updated);
  }

  //Delete -> Excluir um Livro
  Future<void> delete(String id) async {
    await ApiService.delete("livros", id);
  }
}
