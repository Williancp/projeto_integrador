import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:projeto_integrador/models/usuario_admin.dart';
import 'package:projeto_integrador/providers/usuario_provider.dart';
import 'package:projeto_integrador/theme/app_theme.dart';

class UsuarioFormScreen extends StatefulWidget {
  final UsuarioAdmin? usuario;
  final bool isEditing;

  const UsuarioFormScreen({
    Key? key,
    this.usuario,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<UsuarioFormScreen> createState() => _UsuarioFormScreenState();
}

class _UsuarioFormScreenState extends State<UsuarioFormScreen> {
  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _senhaController;
  late TextEditingController _telefoneController;
  late String _tipoUsuario;
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.usuario?.nome ?? '');
    _emailController = TextEditingController(text: widget.usuario?.email ?? '');
    _senhaController = TextEditingController(text: widget.usuario?.senha ?? '');
    _telefoneController = TextEditingController(text: widget.usuario?.telefone ?? '');
    _tipoUsuario = widget.usuario?.tipoUsuario ?? 'COMUM';
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final usuario = UsuarioAdmin(
      idUsuario: widget.usuario?.idUsuario,
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      senha: _senhaController.text.isNotEmpty ? _senhaController.text : null,
      telefone: _emptyToNull(_onlyDigits(_telefoneController.text)),
      tipoUsuario: _tipoUsuario,
    );

    if (widget.isEditing && widget.usuario != null) {
      context.read<UsuarioProvider>().updateUsuario(
            widget.usuario!.idUsuario!,
            usuario,
          );
    } else {
      context.read<UsuarioProvider>().createUsuario(usuario);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Editar Usuario' : 'Novo Usuario'),
        elevation: 0,
      ),
      body: Consumer<UsuarioProvider>(
        builder: (context, usuarioProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informacoes do Usuario',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nome e obrigatorio';
                      }
                      if (value.trim().length < 3) {
                        return 'Informe pelo menos 3 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email e obrigatorio';
                      }
                      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Email invalido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _senhaController,
                    decoration: InputDecoration(
                      labelText: widget.isEditing
                          ? 'Senha (deixe em branco para nao alterar)'
                          : 'Senha',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (!widget.isEditing && (value == null || value.isEmpty)) {
                        return 'Senha e obrigatoria';
                      }
                      if (value != null && value.isNotEmpty && value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _telefoneController,
                    decoration: const InputDecoration(
                      labelText: 'Telefone (opcional)',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9 ()+-]')),
                    ],
                    validator: _validateTelefoneOpcional,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Tipo de Usuario',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.borderGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('Administrador'),
                          subtitle: const Text('Acesso total ao sistema'),
                          value: 'ADMINISTRADOR',
                          groupValue: _tipoUsuario,
                          onChanged: (value) {
                            setState(() {
                              _tipoUsuario = value!;
                            });
                          },
                        ),
                        const Divider(height: 0),
                        RadioListTile<String>(
                          title: const Text('Usuario Comum'),
                          subtitle: const Text('Acesso limitado'),
                          value: 'COMUM',
                          groupValue: _tipoUsuario,
                          onChanged: (value) {
                            setState(() {
                              _tipoUsuario = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (usuarioProvider.error != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        usuarioProvider.error!,
                        style: TextStyle(color: Colors.red[700]),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: usuarioProvider.isLoading ? null : _handleSave,
                          child: usuarioProvider.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text('Salvar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  String _onlyDigits(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  String? _validateTelefoneOpcional(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final digits = _onlyDigits(value);
    if (digits.length < 10 || digits.length > 11) {
      return 'Informe um telefone com DDD';
    }
    return null;
  }
}

