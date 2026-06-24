import 'package:json_annotation/json_annotation.dart';

part 'usuario.g.dart';

@JsonSerializable()
class Usuario {
  @JsonKey(name: 'idUsuario')
  final int? idUsuario;
  
  final String nome;
  final String email;
  final String? telefone;
  
  @JsonKey(name: 'tipoUsuario')
  final String tipoUsuario;

  Usuario({
    this.idUsuario,
    required this.nome,
    required this.email,
    this.telefone,
    required this.tipoUsuario,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$UsuarioToJson(this);

  Usuario copyWith({
    int? idUsuario,
    String? nome,
    String? email,
    String? telefone,
    String? tipoUsuario,
  }) {
    return Usuario(
      idUsuario: idUsuario ?? this.idUsuario,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      tipoUsuario: tipoUsuario ?? this.tipoUsuario,
    );
  }
}
