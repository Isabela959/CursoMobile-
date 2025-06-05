// Classes modelos -> conectar com as entidades do banco de dados

class Paciente{
  // final = ao ser criada, só troca de valor uma única vez
  final int? id; //permite ser nulo, pois o id é gerado automaticamente = ID AUTO INCREMENT
  final String nome;
  final String cpf;
  final String dataNascimento;
  final String telefone;
  final String email;
  final String historicoMedico;

Paciente({
  this.id,
  required this.nome,
  required this.cpf,
  required this.dataNascimento,
  required this.telefone,
  required this.email,
  required this.historicoMedico
});

//métodos de conversão -> objeto para Banco de Dados OU Banco de Dados para objeto

Map<String, dynamic> toMap(){
  return{
    "id": id,
    "nome": nome,
    "cpf": cpf,
    "data_nascimento": dataNascimento,
    "telefone": telefone,
    "email": email,
    "historico_medico": historicoMedico
  };
}

//construtor que converte o Map em um objeto
  factory Paciente.fromMap(Map<String, dynamic> map){
    return Paciente(
      id:map["id"] as int,
      nome:map["nome"] as String,
      cpf:map["cpf"] as String,
      dataNascimento:map["data_nascimento"] as String,
      telefone:map["telefone"] as String,
      email:map["email"] as String,
      historicoMedico:map["historico_medico"] as String);
  }
}