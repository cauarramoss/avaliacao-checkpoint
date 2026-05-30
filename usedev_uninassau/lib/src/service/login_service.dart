import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _baseUrl = 'https://fakestoreapi.com/auth/login';

  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 300) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String? token = data['token'];
        
        if (token != null) {
          await _storage.write(key: 'auth_token', value: token);
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Erro ao realizar login: $e');
      return false;
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
  }
}
