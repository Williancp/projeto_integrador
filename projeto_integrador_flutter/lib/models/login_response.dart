import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String token;
  final String tipo;
  
  @JsonKey(name: 'idUsuario')
  final int idUsuario;
  
  final String nome;
  final String email;
  
  @JsonKey(name: 'tipoUsuario')
  final String tipoUsuario;

  LoginResponse({
    required this.token,
    required this.tipo,
    required this.idUsuario,
    required this.nome,
    required this.email,
    required this.tipoUsuario,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
