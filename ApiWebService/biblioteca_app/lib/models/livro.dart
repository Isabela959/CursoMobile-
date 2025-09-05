class Livro {
  //atributos

  final String? id; //pode ser nulo inicialmente -> id será atribuido pelo bd
  final String titulo;
  final String autor;
  final bool disponivel;

  //construtor
  //required = obrigatório
  Livro({this.id, required this.titulo, required this.autor, required this.disponivel});

  //métodos 
  //ToJson ou ToMap
  Map<String,dynamic> toJson() => {
    "id": id,
    "titulo": titulo,
    "autor": autor,
    "disponivel": disponivel
  };
  //FromJson ou FromMap
  factory Livro.fromJson(Map<String,dynamic> json) =>
  Livro(
    id: json["id"].toString(),
    titulo: json["titulo"].toString(),
    autor: json["autor"].toString(),
    //Quando vem do banco, as vezes volta como variável 0 e 1 em vez de true ou false
    //Ajuste para 
    disponivel: json["disponivel"] == 1 ? true : false,
  );
}
