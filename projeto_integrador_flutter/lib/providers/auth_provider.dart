import 'package:flutter/material.dart';
import 'package:projeto_integrador/services/api_service.dart';
import 'package:projeto_integrador/models/login_response.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService apiService;
  
  LoginResponse? _user;
  bool _isLoading = false;
  String? _error;

  AuthProvider(this.apiService);

  LoginResponse? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null && apiService.isAuthenticated();

  Future<bool> login(String email, String senha) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await apiService.login(email, senha);
      _user = LoginResponse.fromJson(response);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _user = null;
    _error = null;
    await apiService.logout();
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
