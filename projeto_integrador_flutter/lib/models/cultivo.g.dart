// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cultivo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanalVenda _$CanalVendaFromJson(Map<String, dynamic> json) => CanalVenda(
      canalVenda: json['canalVenda'] as String? ?? '',
      percentualVenda: (json['percentualVenda'] as num).toDouble(),
    );

Map<String, dynamic> _$CanalVendaToJson(CanalVenda instance) =>
    <String, dynamic>{
      'canalVenda': instance.canalVenda,
      'percentualVenda': instance.percentualVenda,
    };

Cultivo _$CultivoFromJson(Map<String, dynamic> json) => Cultivo(
      idCultivo: json['idCultivo'] as int?,
      idPropriedade: json['idPropriedade'] as int,
      cultura: json['cultura'] as String,
      canalVenda: json['canalVenda'] as String,
      canaisVenda: (json['canaisVenda'] as List<dynamic>?)
              ?.map((e) => CanalVenda.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      percentualReceita: (json['percentualReceita'] as num?)?.toDouble(),
      anoImplantacao: json['anoImplantacao'] as int?,
      numeroPlantas: json['numeroPlantas'] as int?,
      percentualVendaCanal: (json['percentualVendaCanal'] as num?)?.toDouble(),
      numeroPontosVenda: json['numeroPontosVenda'] as int?,
      distanciaEntrega: (json['distanciaEntrega'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CultivoToJson(Cultivo instance) => <String, dynamic>{
      'idCultivo': instance.idCultivo,
      'idPropriedade': instance.idPropriedade,
      'cultura': instance.cultura,
      'canalVenda': instance.canalVenda,
      'canaisVenda': instance.canaisVenda.map((e) => e.toJson()).toList(),
      'percentualReceita': instance.percentualReceita,
      'anoImplantacao': instance.anoImplantacao,
      'numeroPlantas': instance.numeroPlantas,
      'percentualVendaCanal': instance.percentualVendaCanal,
      'numeroPontosVenda': instance.numeroPontosVenda,
      'distanciaEntrega': instance.distanciaEntrega,
    };
