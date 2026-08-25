import 'dart:convert';

import '../api/api_client.dart';
import 'token_storage.dart';

class AuthService {
  final ApiClient apiClient;
  final TokenStorage tokenStorage;

  AuthService({required this.apiClient, required this.tokenStorage});

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final response = await apiClient.post(
      '/api/token/pair',
      body: {'username': username, 'password': password},
    );

    if (response.statusCode != 200) {
      throw Exception('Login failed: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);

    await tokenStorage.saveTokens(
      accessToken: data['access'],
      refreshToken: data['refresh'],
    );
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      '/api/users/register',
      body: {'email': email, 'password': password},
    );

    if (response.statusCode != 201) {
      throw Exception('Registration failed: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);

    await tokenStorage.saveTokens(
      accessToken: data['access'],
      refreshToken: data['refresh'],
    );
  }

  Future<void> logout() async {
    await tokenStorage.clearTokens();
  }
}
