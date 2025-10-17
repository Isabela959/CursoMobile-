class User {
  String id;
  String nome;
  String nif;
  String email;

  User({
    required this.id,
    required this.nome,
    required this.nif,
    required this.email,
  });

  //métodos de conversão de obj <=> JSON
  //toMap OBJ => Json
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'nif': nif,
      'email': email,
    };
  }

  //fromMap Json => OBJ
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'], 
      nome: map['nome'], 
      nif: map['nif'], 
      email: map['email']
    );
  }
}
