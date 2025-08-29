// Essa tela vai servir tanto para criar um novo usuário, como para alterar um usuário

import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro.dart';
import 'package:biblioteca_app/views/livro/livro_list_view.dart';
import 'package:flutter/material.dart';

class LivroFormView extends StatefulWidget {
  //atributo
  final Livro? livro;

  const LivroFormView({super.key, this.livro});

  @override
  State<LivroFormView> createState() => _LivroFormViewState();
}

class _LivroFormViewState extends State<LivroFormView> {
  //atributos
  final _formkey = GlobalKey<FormState>(); // faz a validação do formulário
  final _controller = LivroController();
  final _tituloField = TextEditingController(); //controla o campo titulo
  final _autorField = TextEditingController(); //controla o campo autor
  bool _disponivel = true; //controla o campo autor

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      _tituloField.text = widget.livro!.titulo;
      _autorField.text = widget.livro!.autor;
      _disponivel = widget.livro!.disponivel;
    }
  }

  // salvar novo usuário
  void _save() async {
    if (_formkey.currentState!.validate()) {
      final livro = Livro(
        // tem que criar o id pq no banco por padrão ele coloca como null (só no Dart)
        id: DateTime.now().millisecond.toString(), //criar um ID
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
        disponivel: _disponivel,
      );
      try {
        await _controller.create(livro);
        //mensagem de criação com sucesso
      } catch (e) {
        //tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LivroListView()),
      );
    }
  }

  // atualizar usuário existente
  void _update() async {
    if (_formkey.currentState!.validate()) {
      final livro = Livro(
        id: widget.livro?.id!, //pegar id existente
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
        disponivel: _disponivel,
      );
      try {
        await _controller.update(livro);
        //mensagem de criação com sucesso
      } catch (e) {
        //tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LivroListView()),
      );
    }
  }

  //build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livro == null ? "Novo Usuário" : "Editar Usuário"),),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _tituloField,
                  decoration: InputDecoration(labelText: "titulo"),
                  validator: (value) => value!.isEmpty ? "Informe o titulo" : null,
                ),
                TextFormField(
                  controller: _autorField,
                  decoration: InputDecoration(labelText: "autor"),
                  validator: (value) => value!.isEmpty ? "Informe o autor" : null,
                ),
                SwitchListTile(
                  title: Text("Disponível"),
                  value: _disponivel, 
                  onChanged: (value) {
                    setState(() {
                      _disponivel = value;
                    });
                  }
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: widget.livro == null ? _save : _update, 
                  child: Text(widget.livro == null ? "Salvar" : "Atualizar"))
              ],
            )),
          ),
    );
  }
}
