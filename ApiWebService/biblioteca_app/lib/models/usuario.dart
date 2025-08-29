class Usuario {
  //atributos

  final String? id; //pode ser nulo inicialmente -> id será atribuido pelo bd
  final String nome;
  final String email;

  //construtor
  Usuario({this.id, required this.nome, required this.email});

  //métodos 
  //ToJson Obj => Map(Json)
  Map<String,dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "email": email
  };
  //FromJson Json(Map) => Obj
  factory Usuario.fromJson(Map<String,dynamic> json) =>
  Usuario(
    id: json["id"].toString(),
    nome: json["nome"].toString(),
    email: json["email"].toString(),
  );
}
