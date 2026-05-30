import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _baseUrl = 'https://fakestoreapi.com/auth/login';

  Future<String?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10));

      // A API retorna 201 (Created) ou 200 (OK) em caso de sucesso
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String? token = data['token'];
        
        if (token != null) {
          await _storage.write(key: 'auth_token', value: token);
          return null; // Sucesso
        }
      }

      if (response.body == 'Error' || response.statusCode == 401) {
        return 'Usuário ou senha inválidos.';
      }

      return 'Erro inesperado (${response.statusCode}): ${response.body}';
      
    } catch (e) {
      return 'Tempo esgotado ou erro de rede. ($e)';
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
  }
}
