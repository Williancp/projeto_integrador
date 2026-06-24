import 'package:json_annotation/json_annotation.dart';

part 'cultivo.g.dart';

@JsonSerializable()
class CanalVenda {
  @JsonKey(name: 'canalVenda')
  final String canalVenda;

  @JsonKey(name: 'percentualVenda')
  final double percentualVenda;

  CanalVenda({
    required this.canalVenda,
    required this.percentualVenda,
  });

  factory CanalVenda.fromJson(Map<String, dynamic> json) =>
      _$CanalVendaFromJson(json);

  Map<String, dynamic> toJson() => _$CanalVendaToJson(this);
}

@JsonSerializable()
class Cultivo {
  @JsonKey(name: 'idCultivo')
  final int? idCultivo;

  @JsonKey(name: 'idPropriedade')
  final int idPropriedade;

  @JsonKey(name: 'cultura')
  final String cultura;

  @JsonKey(name: 'canalVenda')
  final String canalVenda;

  @JsonKey(name: 'canaisVenda')
  final List<CanalVenda> canaisVenda;

  @JsonKey(name: 'percentualReceita')
  final double? percentualReceita;

  @JsonKey(name: 'anoImplantacao')
  final int? anoImplantacao;

  @JsonKey(name: 'numeroPlantas')
  final int? numeroPlantas;

  @JsonKey(name: 'percentualVendaCanal')
  final double? percentualVendaCanal;

  @JsonKey(name: 'numeroPontosVenda')
  final int? numeroPontosVenda;

  @JsonKey(name: 'distanciaEntrega')
  final double? distanciaEntrega;

  Cultivo({
    this.idCultivo,
    required this.idPropriedade,
    required this.cultura,
    required this.canalVenda,
    this.canaisVenda = const [],
    this.percentualReceita,
    this.anoImplantacao,
    this.numeroPlantas,
    this.percentualVendaCanal,
    this.numeroPontosVenda,
    this.distanciaEntrega,
  });

  factory Cultivo.fromJson(Map<String, dynamic> json) =>
      _$CultivoFromJson(json);

  Map<String, dynamic> toJson() => _$CultivoToJson(this);

  Cultivo copyWith({
    int? idCultivo,
    int? idPropriedade,
    String? cultura,
    String? canalVenda,
    List<CanalVenda>? canaisVenda,
    double? percentualReceita,
    int? anoImplantacao,
    int? numeroPlantas,
    double? percentualVendaCanal,
    int? numeroPontosVenda,
    double? distanciaEntrega,
  }) {
    return Cultivo(
      idCultivo: idCultivo ?? this.idCultivo,
      idPropriedade: idPropriedade ?? this.idPropriedade,
      cultura: cultura ?? this.cultura,
      canalVenda: canalVenda ?? this.canalVenda,
      canaisVenda: canaisVenda ?? this.canaisVenda,
      percentualReceita: percentualReceita ?? this.percentualReceita,
      anoImplantacao: anoImplantacao ?? this.anoImplantacao,
      numeroPlantas: numeroPlantas ?? this.numeroPlantas,
      percentualVendaCanal: percentualVendaCanal ?? this.percentualVendaCanal,
      numeroPontosVenda: numeroPontosVenda ?? this.numeroPontosVenda,
      distanciaEntrega: distanciaEntrega ?? this.distanciaEntrega,
    );
  }

  @override
  String toString() =>
      'Cultivo(idCultivo: $idCultivo, cultura: $cultura, canalVenda: $canalVenda)';
}
