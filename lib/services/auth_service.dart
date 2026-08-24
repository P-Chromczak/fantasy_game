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

  Future<void> refreshAccessToken() async {
    final refreshToken = await tokenStorage.getRefreshToken();

    if (refreshToken == null) {
      throw Exception('No refresh token available.');
    }

    final response = await apiClient.post(
      '/api/token/refresh',
      body: {'refresh': refreshToken},
    );

    if (response.statusCode != 200) {
      await tokenStorage.clearTokens();

      throw Exception('Session expired. Please log in again.');
    }

    final data = jsonDecode(response.body);

    final newAccessToken = data['access'];
    final newRefreshToken = data['refresh'];

    if (newAccessToken == null || newRefreshToken == null) {
      throw Exception('Server did not return valid tokens.');
    }

    await tokenStorage.saveTokens(
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,
    );
  }
}
