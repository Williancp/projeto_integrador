import 'package:json_annotation/json_annotation.dart';

part 'usuario_admin.g.dart';

@JsonSerializable()
class UsuarioAdmin {
  @JsonKey(name: 'idUsuario')
  final int? idUsuario;

  @JsonKey(name: 'nome')
  final String nome;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'senha')
  final String? senha;

  @JsonKey(name: 'telefone')
  final String? telefone;

  @JsonKey(name: 'tipoUsuario')
  final String tipoUsuario;

  UsuarioAdmin({
    this.idUsuario,
    required this.nome,
    required this.email,
    this.senha,
    this.telefone,
    required this.tipoUsuario,
  });

  factory UsuarioAdmin.fromJson(Map<String, dynamic> json) =>
      _$UsuarioAdminFromJson(json);

  Map<String, dynamic> toJson() => _$UsuarioAdminToJson(this);

  UsuarioAdmin copyWith({
    int? idUsuario,
    String? nome,
    String? email,
    String? senha,
    String? telefone,
    String? tipoUsuario,
  }) {
    return UsuarioAdmin(
      idUsuario: idUsuario ?? this.idUsuario,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      telefone: telefone ?? this.telefone,
      tipoUsuario: tipoUsuario ?? this.tipoUsuario,
    );
  }

  @override
  String toString() =>
      'UsuarioAdmin(idUsuario: $idUsuario, nome: $nome, email: $email, tipoUsuario: $tipoUsuario)';
}
