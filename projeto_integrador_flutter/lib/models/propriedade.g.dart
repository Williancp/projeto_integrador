// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'propriedade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Propriedade _$PropriedadeFromJson(Map<String, dynamic> json) => Propriedade(
      idPropriedade: (json['idPropriedade'] as num?)?.toInt(),
      nome: json['nome'] as String,
      localidade: json['localidade'] as String?,
      cidade: json['cidade'] as String?,
      telefone: json['telefone'] as String?,
      areaTotal: (json['areaTotal'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      idUsuario: (json['idUsuario'] as num).toInt(),
    );

Map<String, dynamic> _$PropriedadeToJson(Propriedade instance) =>
    <String, dynamic>{
      'idPropriedade': instance.idPropriedade,
      'nome': instance.nome,
      'localidade': instance.localidade,
      'cidade': instance.cidade,
      'telefone': instance.telefone,
      'areaTotal': instance.areaTotal,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'idUsuario': instance.idUsuario,
    };
