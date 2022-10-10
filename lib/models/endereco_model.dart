import 'dart:convert';

class EnderecoModel {
  final String cep;
  final String logradouro;
  final String localidade;
  final String bairro;
  final String uf;

  EnderecoModel({
    required this.cep,
    required this.logradouro,
    required this.localidade,
    required this.bairro,
    required this.uf
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cep': cep,
      'logradouro': logradouro,
      'localidade': localidade,
      'bairro': bairro,
      'uf': uf
    };
  }

  factory EnderecoModel.fromMap(Map<String, dynamic> map) {
    return EnderecoModel(
      cep: map['cep'] as String,
      logradouro: map['logradouro'] as String,
      localidade: map['localidade'] as String,
      bairro: map['bairro'] as String,
      uf: map['uf'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderecoModel.fromJson(String source) =>
      EnderecoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
