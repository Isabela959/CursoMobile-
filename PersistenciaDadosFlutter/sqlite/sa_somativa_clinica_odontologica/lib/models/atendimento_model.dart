// Classe que representa um atendimento realizado para um paciente
class Atendimento {
  final int? id; // Permite o ID do atendimento ser nulo momentaneamente (gerado automaticamente)
  final int pacienteId; 
  final String data; 
  final String hora; 
  final String procedimento; 
  final String dentesEnvolvidos; 
  final String observacoes; 
  final double valor; 

  Atendimento({
    this.id,
    required this.pacienteId,
    required this.data,
    required this.hora,
    required this.procedimento,
    required this.dentesEnvolvidos,
    required this.observacoes,
    required this.valor,
  });

  // Converte o objeto Atendimento para um Map<String, dynamic> para salvar no banco
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pacienteId': pacienteId,
      'data': data,
      'hora': hora,
      'procedimento': procedimento,
      'dentes_envolvidos': dentesEnvolvidos,
      'observacoes': observacoes,
      'valor': valor,
    };
  }

  // Construtor que cria um objeto Atendimento a partir de um Map retornado do banco
  factory Atendimento.fromMap(Map<String, dynamic> map) {
    return Atendimento(
      id: map['id'],
      pacienteId: map['pacienteId'],
      data: map['data'],
      hora: map['hora'],
      procedimento: map['procedimento'],
      dentesEnvolvidos: map['dentes_envolvidos'],
      observacoes: map['observacoes'],
      valor: map['valor'],
    );
  }
}
