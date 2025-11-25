import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  String toString() => 'ApiException: $message';
}

class ApiClient {
  final String baseUrl;
  final FlutterSecureStorage secureStorage;
  final http.Client client;

  ApiClient({required this.baseUrl, required this.secureStorage, http.Client? client})
      : client = client ?? http.Client();

  Future<String?> _getToken() async {
    return await secureStorage.read(key: 'auth_token');
  }

  Future<http.Response> get(String path) async {
    final token = await _getToken();
    final headers = <String, String>{ 'Content-Type': 'application/json' };

    if (token != null) headers['Authorization'] = 'Bearer $token';

    final uri = Uri.parse('$baseUrl$path');
    
    final res = await client.get(uri, headers: headers);
    if (res.statusCode >= 200 && res.statusCode < 300) return res;

    throw ApiException('GET $path failed with status ${res.statusCode}: ${res.body}');
  }

  Future<http.Response> post(String path, dynamic body) async {
    final token = await _getToken();
    final headers = <String, String>{ 'Content-Type': 'application/json' };

    if (token != null) headers['Authorization'] = 'Bearer $token';

    final uri = Uri.parse('$baseUrl$path');
    
    final res = await client.post(uri, headers: headers, body: jsonEncode(body));
    if (res.statusCode >= 200 && res.statusCode < 300) return res;

    throw ApiException('POST $path failed with status ${res.statusCode}: ${res.body}');
  }

  Future<void> saveToken(String token) async {
    await secureStorage.write(key: 'auth_token', value: token);
  }

  Future<void> clearToken() async {
    await secureStorage.delete(key: 'auth_token');
  }
}