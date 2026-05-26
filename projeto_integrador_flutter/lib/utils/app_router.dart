import 'package:flutter/material.dart';
import 'package:projeto_integrador/models/propriedade.dart';
import 'package:projeto_integrador/models/cultivo.dart';
import 'package:projeto_integrador/models/usuario_admin.dart';
import 'package:projeto_integrador/screens/login_screen.dart';
import 'package:projeto_integrador/screens/home_screen.dart';
import 'package:projeto_integrador/screens/propriedade_form_screen.dart';
import 'package:projeto_integrador/screens/propriedade_detail_screen.dart';
import 'package:projeto_integrador/screens/usuario_list_screen.dart';
import 'package:projeto_integrador/screens/usuario_form_screen.dart';
import 'package:projeto_integrador/screens/cultivo_list_screen.dart';
import 'package:projeto_integrador/screens/cultivo_form_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      
      // Rotas de Propriedades
      case '/propriedade/create':
        return MaterialPageRoute(
          builder: (_) => const PropriedadeFormScreen(isEditing: false),
        );
      case '/propriedade/edit':
        final propriedade = settings.arguments as Propriedade;
        return MaterialPageRoute(
          builder: (_) => PropriedadeFormScreen(
            propriedade: propriedade,
            isEditing: true,
          ),
        );
      case '/propriedade/view':
        final propriedade = settings.arguments as Propriedade;
        return MaterialPageRoute(
          builder: (_) => PropriedadeDetailScreen(propriedade: propriedade),
        );
      
      // Rotas de Usuários
      case '/usuario/list':
        return MaterialPageRoute(
          builder: (_) => const UsuarioListScreen(),
        );
      case '/usuario/create':
        return MaterialPageRoute(
          builder: (_) => const UsuarioFormScreen(isEditing: false),
        );
      case '/usuario/edit':
        final usuario = settings.arguments as UsuarioAdmin;
        return MaterialPageRoute(
          builder: (_) => UsuarioFormScreen(
            usuario: usuario,
            isEditing: true,
          ),
        );
      
      // Rotas de Cultivos
      case '/cultivo/list':
        final propriedade = settings.arguments as Propriedade;
        return MaterialPageRoute(
          builder: (_) => CultivoListScreen(propriedade: propriedade),
        );
      case '/cultivo/create':
        final propriedade = settings.arguments as Propriedade;
        return MaterialPageRoute(
          builder: (_) => CultivoFormScreen(
            propriedade: propriedade,
            isEditing: false,
          ),
        );
      case '/cultivo/edit':
        final cultivo = settings.arguments as Cultivo;
        return MaterialPageRoute(
          builder: (_) => CultivoFormScreen(
            cultivo: cultivo,
            isEditing: true,
          ),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Rota não encontrada: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
