import 'package:biblioteca_app/models/emprestimo.dart';
import 'package:biblioteca_app/services/api_service.dart';

class EmprestimoController {
  //métodos
  //Get do Empréstimo
  Future<List<Emprestimo>> fetchAll() async {
    final list = await ApiService.getList("emprestimos?_sort=data_emprestimo");
    return list.map((item) => Emprestimo.fromJson(item)).toList();
  }

  // Get de um único Empréstimo
  Future<Emprestimo> fecthOne(String id) async {
    final emprestimo = await ApiService.getOne("emprestimos", id);
    return Emprestimo.fromJson(emprestimo);
  }

  //Post -> Criar um novo Empréstimo
  Future<Emprestimo> create(Emprestimo emprestimo) async {
    final created = await ApiService.post("emprestimos", emprestimo.toJson());
    return Emprestimo.fromJson(created);
  }

  //Put -> Alterar um Empréstimo
  Future<Emprestimo> update(Emprestimo emprestimo) async {
    final updated = await ApiService.put(
      "emprestimos",
      emprestimo.toJson(),
      emprestimo.id!,
    );
    return Emprestimo.fromJson(updated);
  }

  //Delete -> Deletar um Empréstimo
  Future<void> delete(String id) async {
    await ApiService.delete("emprestimo", id);
  }
}
