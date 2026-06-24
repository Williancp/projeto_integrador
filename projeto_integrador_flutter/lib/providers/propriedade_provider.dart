import 'package:flutter/material.dart';
import 'package:projeto_integrador/services/api_service.dart';
import 'package:projeto_integrador/models/propriedade.dart';

class PropriedadeProvider extends ChangeNotifier {
  final ApiService apiService;
  
  List<Propriedade> _propriedades = [];
  bool _isLoading = false;
  String? _error;

  PropriedadeProvider(this.apiService);

  List<Propriedade> get propriedades => _propriedades;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPropriedades() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await apiService.get('/properties');
      _propriedades = (response as List)
          .map((p) => Propriedade.fromJson(p))
          .toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPropriedadesByUsuario(int idUsuario) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await apiService.get('/properties/usuario/$idUsuario');
      _propriedades = (response as List)
          .map((p) => Propriedade.fromJson(p))
          .toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Propriedade?> createPropriedade(Propriedade propriedade) async {
    try {
      final Map<String, dynamic> data = propriedade.toJson();
      // Garante que o idUsuario seja enviado como Long (int) e não String
      if (data['idUsuario'] is String) {
        data['idUsuario'] = int.parse(data['idUsuario']);
      }
      
      final response = await apiService.post(
        '/properties',
        data,
      );
      final newPropriedade = Propriedade.fromJson(response);
      _propriedades.add(newPropriedade);
      notifyListeners();
      return newPropriedade;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<Propriedade?> updatePropriedade(Propriedade propriedade) async {
    try {
      final Map<String, dynamic> data = propriedade.toJson();
      if (data['idUsuario'] is String) {
        data['idUsuario'] = int.parse(data['idUsuario']);
      }
      
      final response = await apiService.put(
        '/properties/${propriedade.idPropriedade}',
        data,
      );
      final updatedPropriedade = Propriedade.fromJson(response);
      final index = _propriedades.indexWhere(
        (p) => p.idPropriedade == propriedade.idPropriedade,
      );
      if (index != -1) {
        _propriedades[index] = updatedPropriedade;
      }
      notifyListeners();
      return updatedPropriedade;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<bool> deletePropriedade(int id) async {
    try {
      await apiService.delete('/properties/$id');
      _propriedades.removeWhere((p) => p.idPropriedade == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
