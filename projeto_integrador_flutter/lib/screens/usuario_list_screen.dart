import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_integrador/providers/usuario_provider.dart';
import 'package:projeto_integrador/theme/app_theme.dart';

class UsuarioListScreen extends StatefulWidget {
  const UsuarioListScreen({Key? key}) : super(key: key);

  @override
  State<UsuarioListScreen> createState() => _UsuarioListScreenState();
}

class _UsuarioListScreenState extends State<UsuarioListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsuarioProvider>().loadUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Usuários'),
        elevation: 0,
      ),
      body: Consumer<UsuarioProvider>(
        builder: (context, usuarioProvider, _) {
          if (usuarioProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (usuarioProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(usuarioProvider.error!),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UsuarioProvider>().loadUsuarios();
                    },
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }

          if (usuarioProvider.usuarios.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text('Nenhum usuário cadastrado'),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/usuario/create');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar Usuário'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: usuarioProvider.usuarios.length + 1,
            itemBuilder: (context, index) {
              if (index == usuarioProvider.usuarios.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/usuario/create');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar Usuário'),
                  ),
                );
              }

              final usuario = usuarioProvider.usuarios[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: usuario.tipoUsuario == 'ADMINISTRADOR'
                        ? AppTheme.primaryBlue
                        : AppTheme.primaryGreen,
                    child: Icon(
                      usuario.tipoUsuario == 'ADMINISTRADOR'
                          ? Icons.admin_panel_settings
                          : Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(usuario.nome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(usuario.email),
                      Text(
                        usuario.tipoUsuario,
                        style: TextStyle(
                          fontSize: 12,
                          color: usuario.tipoUsuario == 'ADMINISTRADOR'
                              ? AppTheme.primaryBlue
                              : AppTheme.primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/usuario/edit',
                            arguments: usuario,
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 8),
                            Text('Editar'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          _showDeleteConfirmation(context, usuario.idUsuario!);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.delete, size: 18, color: AppTheme.primaryRed),
                            SizedBox(width: 8),
                            Text('Deletar', style: TextStyle(color: AppTheme.primaryRed)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Tem certeza que deseja deletar este usuário?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                context.read<UsuarioProvider>().deleteUsuario(id);
                Navigator.pop(context);
              },
              child: const Text('Deletar', style: TextStyle(color: AppTheme.primaryRed)),
            ),
          ],
        );
      },
    );
  }
}
