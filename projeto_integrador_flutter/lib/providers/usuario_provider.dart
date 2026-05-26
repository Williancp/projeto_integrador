import 'package:flutter/material.dart';
import 'package:projeto_integrador/models/usuario_admin.dart';
import 'package:projeto_integrador/services/api_service.dart';

class UsuarioProvider extends ChangeNotifier {
  final ApiService apiService;

  List<UsuarioAdmin> _usuarios = [];
  bool _isLoading = false;
  String? _error;

  UsuarioProvider({required this.apiService});

  List<UsuarioAdmin> get usuarios => _usuarios;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUsuarios() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await apiService.get('/users');
      if (response is List) {
        _usuarios = response
            .map((json) => UsuarioAdmin.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      _error = null;
    } catch (e) {
      _error = 'Erro ao carregar usuários: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createUsuario(UsuarioAdmin usuario) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await apiService.post('/users', usuario.toJson());
      final novoUsuario = UsuarioAdmin.fromJson(response as Map<String, dynamic>);
      _usuarios.add(novoUsuario);
      _error = null;
    } catch (e) {
      _error = 'Erro ao criar usuário: $e';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUsuario(int id, UsuarioAdmin usuario) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await apiService.put('/users/$id', usuario.toJson());
      final usuarioAtualizado = UsuarioAdmin.fromJson(response as Map<String, dynamic>);
      final index = _usuarios.indexWhere((u) => u.idUsuario == id);
      if (index != -1) {
        _usuarios[index] = usuarioAtualizado;
      }
      _error = null;
    } catch (e) {
      _error = 'Erro ao atualizar usuário: $e';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUsuario(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await apiService.delete('/users/$id');
      _usuarios.removeWhere((u) => u.idUsuario == id);
      _error = null;
    } catch (e) {
      _error = 'Erro ao deletar usuário: $e';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
