import 'package:exemplo_sqlite/controllers/notas_controller.dart';
import 'package:exemplo_sqlite/models/notas_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class NotaScreen extends StatefulWidget {
  @override
  State<NotaScreen> createState() => _NotaScreenState();
}

class _NotaScreenState extends State<NotaScreen> {
  final NotasController _notasController = NotasController();

  // Lista para as notas
  List<Nota> _notes = [];
  bool _isLoanding = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNotas(); // carregar as notas no início
  }

  Future<void> _loadNotas() async {
    setState(() {
      _isLoanding = true;
    });
    try {
      _notes= await _notasController.fetchNotas();
    } catch (e) {
      print("Erro ao Carregar : $e");
      _notes = [];
    }finally {
      setState(() {
        _isLoanding = false; // finaliza o estado de carregamento
      });
    }
  }

  Future<void> _addNotas() async {
    Nota notaNova = Nota(titulo: "Nota ${DateTime.now()}", conteudo: "Conteúdo da Nota");
    final id = await _notasController.addNota(novaNota);
    _loadNotas();
  }

  Future<void> _updateNota(Nota nota) async {
    Nota notaAtualizada = Nota(id: nota.id, titulo: "${nota.titulo} (editado)", conteudo: nota.conteudo);
    final update = await _notasController.updateNota(notaAtualizada);
    _loadNotas();
    //showDialog
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Minhas Notas"),),
      body: _isLoanding ? Center (child: CircularProgressIndicator()) : ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (Context, index){
          final nota = _notes[index];
          return ListTile(
            title: Text(nota.titulo),
            subtitle: Text(nota.conteudo),
            onTap: () => _updateNota(nota),
            onLongPress: () => _deleteNota(nota.id!),
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNotas,
          tooltip: "Adicionar Nota",
          child: Icon(Icons.add),),
    );
  }

}