import 'package:flutter/material.dart';
import 'package:projeto_integrador/models/cultivo.dart';
import 'package:projeto_integrador/services/api_service.dart';

class CultivoProvider extends ChangeNotifier {
  final ApiService apiService;

  List<Cultivo> _cultivos = [];
  bool _isLoading = false;
  String? _error;

  CultivoProvider({required this.apiService});

  List<Cultivo> get cultivos => _cultivos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCultivosByPropriedade(int idPropriedade) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await apiService.get('/cultivos/propriedade/$idPropriedade');
      if (response is List) {
        _cultivos = response
            .map((json) => Cultivo.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      _error = null;
    } catch (e) {
      _error = 'Erro ao carregar cultivos: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createCultivo(Cultivo cultivo) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final Map<String, dynamic> data = cultivo.toJson();
      // Garantir que o idPropriedade seja enviado como número
      if (data['idPropriedade'] is String) {
        data['idPropriedade'] = int.parse(data['idPropriedade']);
      }
      
      final response = await apiService.post('/cultivos', data);
      final novoCultivo = Cultivo.fromJson(response as Map<String, dynamic>);
      _cultivos.add(novoCultivo);
      _error = null;
    } catch (e) {
      _error = 'Erro ao criar cultivo: $e';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCultivo(int id, Cultivo cultivo) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final Map<String, dynamic> data = cultivo.toJson();
      // Garantir que o idPropriedade seja enviado como número
      if (data['idPropriedade'] is String) {
        data['idPropriedade'] = int.parse(data['idPropriedade']);
      }

      final response = await apiService.put('/cultivos/$id', data);
      final cultivoAtualizado = Cultivo.fromJson(response as Map<String, dynamic>);
      final index = _cultivos.indexWhere((c) => c.idCultivo == id);
      if (index != -1) {
        _cultivos[index] = cultivoAtualizado;
      }
      _error = null;
    } catch (e) {
      _error = 'Erro ao atualizar cultivo: $e';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCultivo(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await apiService.delete('/cultivos/$id');
      _cultivos.removeWhere((c) => c.idCultivo == id);
      _error = null;
    } catch (e) {
      _error = 'Erro ao deletar cultivo: $e';
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
