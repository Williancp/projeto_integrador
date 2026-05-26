// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario(
      idUsuario: (json['idUsuario'] as num?)?.toInt(),
      nome: json['nome'] as String,
      email: json['email'] as String,
      telefone: json['telefone'] as String?,
      tipoUsuario: json['tipoUsuario'] as String,
    );

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'idUsuario': instance.idUsuario,
      'nome': instance.nome,
      'email': instance.email,
      'telefone': instance.telefone,
      'tipoUsuario': instance.tipoUsuario,
    };
