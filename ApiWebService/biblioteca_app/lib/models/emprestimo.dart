class Emprestimo {
  //atributos

  final String? id; //pode ser nulo inicialmente -> id será atribuido pelo bd
  final String usuario_id;
  final String livro_id;
  final String data_emprestimo;
  final String data_devolucao;
  final bool devolvido;

  //construtor
  Emprestimo({this.id, required this.usuario_id, required this.livro_id, required this.data_emprestimo, required this.data_devolucao, required this.devolvido});

  //métodos 
  //ToJson ou ToMap
  Map<String,dynamic> toJson() => {
    "id": id,
    "usuario_id": usuario_id,
    "livro_id": livro_id,
    "data_emprestimo": data_emprestimo,
    "data_devolucao": data_devolucao,
    "devolvido": devolvido
  };
  //FromJson ou FromMap
  factory Emprestimo.fromJson(Map<String,dynamic> json) =>
  Emprestimo(
    id: json["id"].toString(),
    usuario_id: json["usuario_id"].toString(),
    livro_id: json["livro_id"].toString(),
    data_emprestimo: json["data_emprestimo"].toString(),
    data_devolucao: json["data_devolucao"].toString(),
    devolvido: json["devolvido"] == 1 ? true : false,
  );
}

