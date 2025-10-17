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

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'nif': nif,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'], 
      nome: map['nome'], 
      nif: map['nif'], 
      email: map['email']
    );
  }
}
