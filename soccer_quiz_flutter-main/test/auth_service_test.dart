import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soccer_quiz_flutter/data/repositories/auth_repository.dart';
import 'package:soccer_quiz_flutter/data/api/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}
class MockStorage extends Mock implements FlutterSecureStorage {}

void main() {
  test('AuthRepository login stores token on success', () async {
    final client = MockClient();
    final storage = MockStorage();
    final api = ApiClient(baseUrl: 'https://api.test', secureStorage: storage, client: client);
    when(client.post(Uri.parse('https://api.test/auth/login'), headers: anyNamed('headers'), body: anyNamed('body')))
      .thenAnswer((_) async => http.Response(jsonEncode({'token':'abc123'}), 200));
    final repo = AuthRepository(apiClient: api);
    final token = await repo.login('a@b.com','pass');
    expect(token, 'abc123');
  });
}