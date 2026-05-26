// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioAdmin _$UsuarioAdminFromJson(Map<String, dynamic> json) => UsuarioAdmin(
      idUsuario: json['idUsuario'] as int?,
      nome: json['nome'] as String,
      email: json['email'] as String,
      senha: json['senha'] as String?,
      telefone: json['telefone'] as String?,
      tipoUsuario: json['tipoUsuario'] as String,
    );

Map<String, dynamic> _$UsuarioAdminToJson(UsuarioAdmin instance) =>
    <String, dynamic>{
      'idUsuario': instance.idUsuario,
      'nome': instance.nome,
      'email': instance.email,
      'senha': instance.senha,
      'telefone': instance.telefone,
      'tipoUsuario': instance.tipoUsuario,
    };
