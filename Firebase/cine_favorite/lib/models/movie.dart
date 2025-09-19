// classe de modelagem do OBJ Movie
// receber os dados da API -> enviar os dados para o FireStore
// Usar o Firebase para salvar os itens favoritos do usuário

class Movie {
  //atributos
  final int id; //ID do filme no tmdb
  final String title; // Título do filme
  final String
  posterPath; //caminho da imagem do poster (path de armazenamento interno)
  double rating; //nota que o usuário dará ao filme (de 0 a 5)

  //construtor
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0.0,
  });

  //métodos de conversão de obj <=> JSON
  //toMap OBJ => Json
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "posterPath": posterPath,
      "rating": rating,
    };
  }

  //fromMap Json => OBJ
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map["id"],
      title: map["title"],
      posterPath: map["posterPath"],
      rating: (map["rating"] as num).toDouble() 
    );
  }
}
