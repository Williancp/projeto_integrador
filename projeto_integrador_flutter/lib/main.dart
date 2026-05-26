import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_integrador/services/api_service.dart';
import 'package:projeto_integrador/providers/auth_provider.dart';
import 'package:projeto_integrador/providers/propriedade_provider.dart';
import 'package:projeto_integrador/providers/usuario_provider.dart';
import 'package:projeto_integrador/providers/cultivo_provider.dart';
import 'package:projeto_integrador/theme/app_theme.dart';
import 'package:projeto_integrador/utils/app_router.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final apiService = ApiService();
  await apiService.init();
  
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => apiService),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => PropriedadeProvider(apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => UsuarioProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => CultivoProvider(apiService: apiService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Integrador',
      theme: AppTheme.lightTheme,
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return authProvider.isAuthenticated
              ? const HomeScreen()
              : const LoginScreen();
        },
      ),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
