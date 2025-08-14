import 'dart:convert';
import 'dart:io'; //bibiioteca interna do dart - busca os diretórios da aplicação

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MaterialApp(home: ProdutoPage(),)); // uso do callback

class ProdutoPage extends StatefulWidget {
  //construtor
  const ProdutoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProdutoPageState();
  }
}

// classe que constroi a tela com as mudanças
class _ProdutoPageState extends State<ProdutoPage> {
  //lista de coleções
  List<Map<String, dynamic>> _produtos = [];
  // controlador de edição dos campos de texto
  // final = permite mudar a variável uma vez
  // o underline é deixar privado para não ter acesso fora da classe
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _valorProdutoController = TextEditingController();

  // métodos

  @override
  void initState() {
    super.initState(); // buscar informações antes de construir a tela
    _carregarProdutos();
  }

  //path_provider (Permite buscar arquivos do Dispositivo Local)
  // instalar o package do path_provider

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/produtos.json");
  }

  // async: não para a aplicação para rodar o método (SIMULTÂNEO)
  void _carregarProdutos() async {
    // tratamento de erros
    try {
      final file = await _getFile();
      String jsonProdutos = await file.readAsString();
      List<dynamic> dados = json.decode(jsonProdutos);
      // preencher a lista com os items da base de dados(file)
      setState(() {
        _produtos = dados.cast<Map<String, dynamic>>(); //
      });
    } catch (e) {
      _produtos = [];
      print("Erro ao carregar arquivo $e");
    }
  }

  void _salvarProdutos() async {
    try {
      final file = await _getFile();
      String jsonProduto = json.encode(_produtos);
      await file.writeAsString(jsonProduto);
    } catch (e) {
      print("Erro ao salvar Produtos: $e");
    }
  }

  // adicionar produtos na lista
  void _adicionarProduto() {
    String nome = _nomeProdutoController.text.trim();
    String valorStr = _valorProdutoController.text.trim();
    if (nome.isEmpty || valorStr.isEmpty)
      return; // interrompe o método -> caso algum vazio
    double? valor = double.tryParse(valorStr);
    if (valor == null)
      return; // interrompe o método -> caso não consiga converter

    final produto = {"nome": nome, "valor": valor};
    setState(() {
      _produtos.add(produto);
    });
    _nomeProdutoController.clear();
    _valorProdutoController.clear();
    _salvarProdutos();
  }

  //remover produtos da lista
  void _removerProduto(int index) {
    setState(() {
      _produtos.removeAt(index);
    });
    _salvarProdutos();
  }

  //build mda Tela
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Produtos"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeProdutoController,
              decoration: InputDecoration(labelText: "Nome do Produto"),
            ),
            TextField(
              controller: _valorProdutoController,
              decoration: InputDecoration(labelText: "Valor do Produto (ex: 15.55)"),
              // muda o teclado só para números
              keyboardType: TextInputType.numberWithOptions(decimal: true), 
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: _adicionarProduto, 
            child: Text("Adicionar Produto")),
            Divider(),
            Expanded(
              child: Text("Adicionar Produto")),
              Divider(),
              Expanded(
                child: _produtos.isEmpty ?
                Center(child: Text("Nenhum Produto Cadastrado"),) :
                ListView.builder(
                  itemCount: _produtos.length,
                  itemBuilder: (context,index){
                    final produto = _produtos[index];
                    return ListTile(
                      title: Text(produto["nome"]),
                      subtitle: Text(
                        "R\$ ${produto["Valor"]}"
                        ),
                      trailing: IconButton(
                        onPressed: () => _removerProduto(index),
                         icon: Icon(Icons.delete),
                      ),
                    );
                  })
                ),
              
            ],
          ),
        ),
      );
  }
}
