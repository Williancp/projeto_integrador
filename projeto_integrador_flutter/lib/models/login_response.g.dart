// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String,
      tipo: json['tipo'] as String,
      idUsuario: (json['idUsuario'] as num).toInt(),
      nome: json['nome'] as String,
      email: json['email'] as String,
      tipoUsuario: json['tipoUsuario'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'tipo': instance.tipo,
      'idUsuario': instance.idUsuario,
      'nome': instance.nome,
      'email': instance.email,
      'tipoUsuario': instance.tipoUsuario,
    };
