class Livro {
  //atributos

  final String? id; //pode ser nulo inicialmente -> id será atribuido pelo bd
  final String titulo;
  final String autor;
  final bool disponivel;

  //construtor
  Livro({this.id, required this.titulo, required this.autor, required this.disponivel});

  //métodos 
  //ToJson
  Map<String,dynamic> toJson() => {
    "id": id,
    "nome": titulo,
    "email": autor,
    "disponivel": disponivel
  };
  //FromJson
  factory Livro.fromJson(Map<String,dynamic> json) =>
  Livro(
    id: json["id"].toString(),
    titulo: json["titulo"].toString(),
    autor: json["autor"].toString(),
    disponivel: json["disponivel"].toString(),
  );
}
