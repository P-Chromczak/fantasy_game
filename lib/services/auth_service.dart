import '../api/api_client.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService({
    required this.apiClient,
  });

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final response = await apiClient.post(
      '/api/token/pair',
      body: {
        'username': username,
        'password': password,
      },
    );

    print('Status: ${response.statusCode}');
    print('Response: ${response.body}');
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      '/api/users/register',
      body: {
        'email': email,
        'password': password,
      },
    );

    print('Status: ${response.statusCode}');
    print('Response: ${response.body}');
  }
}

  