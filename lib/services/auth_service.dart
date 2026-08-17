import '../api/api_client.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService({
    required this.apiClient,
  });

  Future<void> login({
    required String name,
    required String password,
  }) async {
    final response = await apiClient.post(
      '/auth/login',
      body: {
        'name': name,
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

  