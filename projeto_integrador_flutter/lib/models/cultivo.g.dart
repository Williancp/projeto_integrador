// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cultivo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cultivo _$CultivoFromJson(Map<String, dynamic> json) => Cultivo(
      idCultivo: json['idCultivo'] as int?,
      idPropriedade: json['idPropriedade'] as int,
      cultura: json['cultura'] as String,
      canalVenda: json['canalVenda'] as String,
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
      'percentualReceita': instance.percentualReceita,
      'anoImplantacao': instance.anoImplantacao,
      'numeroPlantas': instance.numeroPlantas,
      'percentualVendaCanal': instance.percentualVendaCanal,
      'numeroPontosVenda': instance.numeroPontosVenda,
      'distanciaEntrega': instance.distanciaEntrega,
    };
