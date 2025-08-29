import 'package:biblioteca_app/views/emprestimo/emprestimo_list_view.dart';
import 'package:biblioteca_app/views/livro/livro_list_view.dart';
import 'package:biblioteca_app/views/usuario/usuario_list_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _index = 0; // índice de navegação das páginas
  final List<Widget> _paginas = [
    LivroListView(),
    EmprestimoListView(),
    UsuarioListView(),
  ];

  //build da Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerenciador de Biblioteca"),),
      body: _paginas[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(() => _index = value,),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label:"Livros"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label:"Empréstimos"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label:"Usuários"),
        ]),
    );
  }
}
