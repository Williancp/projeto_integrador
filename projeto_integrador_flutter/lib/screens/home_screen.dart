import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_integrador/providers/auth_provider.dart';
import 'package:projeto_integrador/providers/propriedade_provider.dart';
import 'package:projeto_integrador/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthProvider>().user?.idUsuario;
    if (userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<PropriedadeProvider>().loadPropriedadesByUsuario(userId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Dados Rurais'),
        elevation: 0,
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.person, size: 20),
                        SizedBox(width: 8),
                        Text('Perfil'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    onTap: () {
                      context.read<AuthProvider>().logout();
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.logout, size: 20, color: AppTheme.primaryRed),
                        SizedBox(width: 8),
                        Text('Sair', style: TextStyle(color: AppTheme.primaryRed)),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.landscape),
            label: 'Propriedades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildPropriedadesList();
      case 2:
        return _buildProfile();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final isAdmin = authProvider.user?.tipoUsuario == 'ADMINISTRADOR';

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bem-vindo!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      authProvider.user?.nome ?? 'Usuário',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        authProvider.user?.tipoUsuario ?? 'Usuário',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Ações Rápidas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  if (isAdmin)
                    _buildActionCard(
                      icon: Icons.person_add,
                      title: 'Cadastrar\nUsuário',
                      color: AppTheme.primaryGreen,
                      onTap: () {
                        Navigator.of(context).pushNamed('/usuario/create');
                      },
                    ),
                  if (isAdmin)
                    _buildActionCard(
                      icon: Icons.people,
                      title: 'Listar\nUsuários',
                      color: AppTheme.primaryBlue,
                      onTap: () {
                        Navigator.of(context).pushNamed('/usuario/list');
                      },
                    ),
                  _buildActionCard(
                    icon: Icons.add_location,
                    title: 'Cadastrar\nPropriedade',
                    color: AppTheme.primaryYellow,
                    onTap: () {
                      Navigator.of(context).pushNamed('/propriedade/create');
                    },
                  ),
                  _buildActionCard(
                    icon: Icons.list_alt,
                    title: 'Listar\nPropriedades',
                    color: AppTheme.primaryRed,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                color.withOpacity(0.7),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropriedadesList() {
    return Consumer<PropriedadeProvider>(
      builder: (context, propriedadeProvider, _) {
        if (propriedadeProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (propriedadeProvider.propriedades.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.landscape, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                const Text('Nenhuma propriedade cadastrada'),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/propriedade/create');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar Propriedade'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: propriedadeProvider.propriedades.length + 1,
          itemBuilder: (context, index) {
            if (index == propriedadeProvider.propriedades.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/propriedade/create');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar Propriedade'),
                ),
              );
            }

            final propriedade = propriedadeProvider.propriedades[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(
                  Icons.landscape,
                  color: AppTheme.primaryGreen,
                ),
                title: Text(propriedade.nome),
                subtitle: Text(propriedade.cidade ?? 'Sem cidade'),
                trailing: PopupMenuButton(
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/cultivo/list',
                          arguments: propriedade,
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.agriculture, size: 18),
                          SizedBox(width: 8),
                          Text('Cultivos'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/propriedade/edit',
                          arguments: propriedade,
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
                        _showDeleteConfirmation(
                          context,
                          propriedade.idPropriedade!,
                        );
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
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/propriedade/view',
                    arguments: propriedade,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProfile() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final user = authProvider.user;
        if (user == null) {
          return const Center(child: Text('Usuário não autenticado'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Informações Pessoais',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildProfileField('Nome', user.nome),
              _buildProfileField('Email', user.email),
              _buildProfileField('Tipo', user.tipoUsuario),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<AuthProvider>().logout();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Sair'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryRed,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.borderGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Tem certeza que deseja deletar esta propriedade?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                context.read<PropriedadeProvider>().deletePropriedade(id);
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
