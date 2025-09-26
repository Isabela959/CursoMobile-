import 'dart:io';

import 'package:cine_favorite/controllers/movie_firestore_controller.dart';
import 'package:cine_favorite/models/movie.dart';
import 'package:cine_favorite/views/search_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  // atributo
  final _movieFireStoreController = MovieFirestoreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmes Favoritos"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      //criar uma gridView com os filmes favoritos
      body: StreamBuilder<List<Movie>>(
        stream: _movieFireStoreController.getFavoriteMovies(),
        builder: (context, snapshot) {
          //se deu erro
          if (snapshot.hasError) {
            return Center(child: Text("Erro ao Carregar a Lista de Favoritos"));
          }
          // enquanto carrega a lista
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          //quando a lista esta vazia
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum Filme Adicionado Aos Favoritos"));
          }
          //a construção da lista
          final favoriteMovies = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              //criar um obj de Movie
              final movie = favoriteMovies[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onLongPress: () async {
                          final confirm = await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Remover dos Favoritos"),
                              content: Text("Deseja remover \"${movie.title}\" dos favoritos?"),
                              actions: [
                                TextButton(
                                  child: Text("Cancelar"),
                                  onPressed: () => Navigator.pop(context, false),
                                ),
                                TextButton(
                                  child: Text("Remover"),
                                  onPressed: () => Navigator.pop(context, true),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            _movieFireStoreController.removeFavoriteMovie(movie.id);
                          }
                        },
                        // 👇 a imagem agora é a área "tocável"
                        child: Image.file(
                          File(movie.posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // título
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(movie.title),
                    ),
                    // nota
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(movie.rating.toString()),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchMovieView()),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}
