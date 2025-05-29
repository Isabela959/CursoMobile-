// classes modelos -> conectar com as entidades do banco de dados

class Pet{
  // final = ao ser criada, só troca de valor uma única vez
  final int? id; //permite ser nulo, pois o id é gerado automaticamente = ID AUTO INCREMENT
  final String nome;
  final String raca;
  final String nomeDono;
  final String telefoneDono;

  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.nomeDono,
    required this.telefoneDono
  });

  //métodos de conversão -> objeto para Banco de Dados OU Banco de Dados para objeto

  Map<String, dynamic> toMap(){
    return{
      "id": id,
      "nome": nome,
      "raca": raca,
      "nome_dono": nomeDono, // Não se utiliza letra maiúscula em banco de dados
      "telefone_dono": telefoneDono
    };
  }

  //construtor que converte o Map em um objeto
  factory Pet.fromMap(Map<String, dynamic> map){
    return Pet(
      id:map["id"] as int,
      nome:map["nome"] as String,
      raca:map["raca"] as String,
      nomeDono:map["nome_dono"] as String,
      telefoneDono:map["telefone_dono"] as String);
  }

}