import 'package:json_annotation/json_annotation.dart';

part 'propriedade.g.dart';

@JsonSerializable()
class Propriedade {
  @JsonKey(name: 'idPropriedade')
  final int? idPropriedade;
  
  final String nome;
  final String? localidade;
  final String? cidade;
  final String? telefone;
  
  @JsonKey(name: 'areaTotal')
  final double? areaTotal;
  
  final double? latitude;
  final double? longitude;
  
  @JsonKey(name: 'idUsuario')
  final int idUsuario;

  Propriedade({
    this.idPropriedade,
    required this.nome,
    this.localidade,
    this.cidade,
    this.telefone,
    this.areaTotal,
    this.latitude,
    this.longitude,
    required this.idUsuario,
  });

  factory Propriedade.fromJson(Map<String, dynamic> json) =>
      _$PropriedadeFromJson(json);

  Map<String, dynamic> toJson() => _$PropriedadeToJson(this);

  Propriedade copyWith({
    int? idPropriedade,
    String? nome,
    String? localidade,
    String? cidade,
    String? telefone,
    double? areaTotal,
    double? latitude,
    double? longitude,
    int? idUsuario,
  }) {
    return Propriedade(
      idPropriedade: idPropriedade ?? this.idPropriedade,
      nome: nome ?? this.nome,
      localidade: localidade ?? this.localidade,
      cidade: cidade ?? this.cidade,
      telefone: telefone ?? this.telefone,
      areaTotal: areaTotal ?? this.areaTotal,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      idUsuario: idUsuario ?? this.idUsuario,
    );
  }
}
