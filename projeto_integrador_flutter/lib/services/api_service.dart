import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080/api';
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userTypeKey = 'user_type';
  
  final logger = Logger();
  late SharedPreferences _prefs;
  String? _token;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString(_tokenKey);
    logger.i('ApiService initialized with token: ${_token != null ? "Present" : "Null"}');
  }

  Future<dynamic> login(String email, String senha) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'senha': senha,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token'];
        await _prefs.setString(_tokenKey, _token!);
        await _prefs.setInt(_userIdKey, data['idUsuario']);
        await _prefs.setString(_userTypeKey, data['tipoUsuario']);
        logger.i('Login successful');
        return data;
      } else {
        logger.e('Login failed: ${response.statusCode}');
        throw Exception('Falha ao fazer login');
      }
    } catch (e) {
      logger.e('Login error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    _token = null;
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userIdKey);
    await _prefs.remove(_userTypeKey);
    logger.i('Logout successful');
  }

  Future<dynamic> get(String endpoint) async {
    try {
      // Ajuste para evitar duplicidade de /api se o endpoint já começar com /api
      final String finalEndpoint = endpoint.startsWith('/api') ? endpoint.substring(4) : endpoint;
      final response = await http.get(
        Uri.parse('$baseUrl$finalEndpoint'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        await logout();
        throw Exception('Sessão expirada');
      } else {
        throw Exception('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('GET error: $e');
      rethrow;
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final String finalEndpoint = endpoint.startsWith('/api') ? endpoint.substring(4) : endpoint;
      final response = await http.post(
        Uri.parse('$baseUrl$finalEndpoint'),
        headers: _getHeaders(),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        await logout();
        throw Exception('Sessão expirada');
      } else {
        throw Exception('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('POST error: $e');
      rethrow;
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final String finalEndpoint = endpoint.startsWith('/api') ? endpoint.substring(4) : endpoint;
      final response = await http.put(
        Uri.parse('$baseUrl$finalEndpoint'),
        headers: _getHeaders(),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        await logout();
        throw Exception('Sessão expirada');
      } else {
        throw Exception('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('PUT error: $e');
      rethrow;
    }
  }

  Future<void> delete(String endpoint) async {
    try {
      final String finalEndpoint = endpoint.startsWith('/api') ? endpoint.substring(4) : endpoint;
      final response = await http.delete(
        Uri.parse('$baseUrl$finalEndpoint'),
        headers: _getHeaders(),
      );

      if (response.statusCode != 204) {
        if (response.statusCode == 401) {
          await logout();
          throw Exception('Sessão expirada');
        } else {
          throw Exception('Erro na requisição: ${response.statusCode}');
        }
      }
    } catch (e) {
      logger.e('DELETE error: $e');
      rethrow;
    }
  }

  Map<String, String> _getHeaders() {
    final headers = {'Content-Type': 'application/json'};
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  bool isAuthenticated() => _token != null;

  String? getToken() => _token;

  int? getUserId() => _prefs.getInt(_userIdKey);

  String? getUserType() => _prefs.getString(_userTypeKey);
}
