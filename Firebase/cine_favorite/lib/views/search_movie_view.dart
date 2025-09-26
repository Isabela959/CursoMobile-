// Tela de Procura de Filme na API

import 'package:cine_favorite/controllers/movie_firestore_controller.dart';
import 'package:cine_favorite/services/tmdb_service.dart';
import 'package:flutter/material.dart';

class SearchMovieView extends StatefulWidget {
  const SearchMovieView({super.key});

  @override
  State<SearchMovieView> createState() => _SearchMovieViewState();
}

class _SearchMovieViewState extends State<SearchMovieView> {
  //atributos
  final _movieFireStoreController = MovieFirestoreController();
  final _searchField = TextEditingController();

  List<Map<String,dynamic>> _movies = [];

  bool _isLoading = false;

  void _searchMovies() async{
    //´pega o texto digitado no textField
    final query = _searchField.text.trim();
    if(query.isEmpty) return; //para o método

    setState(() {
      _isLoading = true;
    });
    try {
      final result = await TmdbService.searchMovies(query);
      setState(() {
        //passa o resultado da busca para a lista
        _movies = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _movies=[];
        _isLoading = false;
      });
      //mostrar uma mensagem de erro

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar Filme"),),
      body: Padding(padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchField,
            decoration: InputDecoration(
              labelText: "Nome do Filme",
              border: OutlineInputBorder(),
              suffix: IconButton(
                onPressed: _searchMovies, icon: Icon(Icons.search))
            ),
          ),
          SizedBox(height: 10,),
          //operador Ternário
          _isLoading ? CircularProgressIndicator()
          //outro Operador Ternário
          : _movies.isEmpty ? Text("Nenhum Filme Encontrado")
          : Expanded(
            child: ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index){
                final movie = _movies[index];
                return ListTile(
                  leading: 
                  Image.network(
                    "https://image.tmdb.org/t/p/w500${movie["poster_path"]}",
                    height: 50),
                  title: Text(movie["title"]),
                  subtitle: Text(movie["release_date"]),
                  trailing: IconButton(
                    onPressed: () async{
                      //adicionar o filme aos favoritos
                      _movieFireStoreController.addFavoriteMovie(movie);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${movie["title"]} adicionado com sucesso"))
                      );
                      Navigator.pop(context); //volto para tela de favoritos
                    }, icon: Icon(Icons.add)),
                  );
                }
              )
            )
          ],
        ),
      ),
    );
  }
}