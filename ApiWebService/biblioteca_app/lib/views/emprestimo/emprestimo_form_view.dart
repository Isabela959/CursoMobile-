import 'package:biblioteca_app/controllers/emprestimo_controller.dart';
import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/controllers/user_controller.dart';
import 'package:biblioteca_app/models/livro.dart';
import 'package:biblioteca_app/models/usuario.dart';
import 'package:biblioteca_app/views/emprestimo/emprestimo_list_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // para formatar data

class EmprestimoFormView extends StatefulWidget {
  const EmprestimoFormView({super.key});

  @override
  State<EmprestimoFormView> createState() => _EmprestimoFormViewState();
}

class _EmprestimoFormViewState extends State<EmprestimoFormView> {
  final _formkey = GlobalKey<FormState>();
  final _controller = EmprestimoController();
  final _userController = UsuarioController();
  final _livroController = LivroController();

  Usuario? _usuario;
  Livro? _livro;
  DateTime? _dataDevolucao; // nova data prevista de devolução

  List<Usuario> _usuarios = [];
  List<Livro> _livros = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() => _loading = true);
    try {
      _usuarios = await _userController.fetchAll();
      _livros = await _livroController.fetchDisponiveis();
    } catch (e) {
      // tratar erro
    }
    setState(() => _loading = false);
  }

  void _escolherData() async {
    final hoje = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: hoje.add(Duration(days: 7)), // default +7 dias
      firstDate: hoje,
      lastDate: hoje.add(Duration(days: 365)), // até 1 ano à frente
    );
    if (picked != null) {
      setState(() {
        _dataDevolucao = picked;
      });
    }
  }

  void _save() async {
    if (_formkey.currentState!.validate()) {
      if (_usuario == null || _livro == null || _dataDevolucao == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Preencha todos os campos.")),
        );
        return;
      }

      try {
        await _controller.create(
          usuario: _usuario!,
          livro: _livro!,
          dataDevolucao: _dataDevolucao!,
        );
      } catch (e) {
        // tratar erro
      }

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmprestimoListView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo Empréstimo")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    DropdownButtonFormField<Usuario>(
                      decoration: InputDecoration(labelText: "Usuário"),
                      items: _usuarios
                          .map((u) =>
                              DropdownMenuItem(value: u, child: Text(u.nome)))
                          .toList(),
                      onChanged: (value) => setState(() => _usuario = value),
                      validator: (value) =>
                          value == null ? "Selecione um usuário" : null,
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<Livro>(
                      decoration: InputDecoration(labelText: "Livro"),
                      items: _livros
                          .map((l) =>
                              DropdownMenuItem(value: l, child: Text(l.titulo)))
                          .toList(),
                      onChanged: (value) => setState(() => _livro = value),
                      validator: (value) =>
                          value == null ? "Selecione um livro" : null,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _dataDevolucao == null
                                ? "Nenhuma data escolhida"
                                : "Devolver até: ${DateFormat('dd/MM/yyyy').format(_dataDevolucao!)}",
                          ),
                        ),
                        TextButton(
                          onPressed: _escolherData,
                          child: Text("Escolher Data"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _save,
                      child: Text("Salvar Empréstimo"),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
