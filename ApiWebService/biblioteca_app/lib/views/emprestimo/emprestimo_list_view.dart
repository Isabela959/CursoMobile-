import 'package:biblioteca_app/controllers/emprestimo_controller.dart';
import 'package:biblioteca_app/models/emprestimo.dart';
import 'package:flutter/material.dart';

class EmprestimoListView extends StatefulWidget {
  const EmprestimoListView({super.key});

  @override
  State<EmprestimoListView> createState() => _EmprestimoListViewState();
}

class _EmprestimoListViewState extends State<EmprestimoListView> {
  // atributos
  final _controller = EmprestimoController(); // chama o controller
  List<Emprestimo> _emprestimos = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() => _loading = true);
    try {
      _emprestimos = await _controller.fetchAll();
    } catch (e) {
      //tratar erro
    }
    setState(() => _loading = false);
  }

  void _openForm() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmprestimoListView()),
    );
    _load();
  }
}
