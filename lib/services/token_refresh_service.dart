import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'token_storage.dart';

class TokenRefreshService {
  final String baseUrl;
  final TokenStorage tokenStorage;

  TokenRefreshService({
    required this.baseUrl,
    required this.tokenStorage,
  });

  Future<bool> refreshAccessToken() async {
    final refreshToken = await tokenStorage.getRefreshToken();

    if (refreshToken == null) {
      return false;
    }

    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/token/refresh'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'refresh': refreshToken,
            }),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        await tokenStorage.clearTokens();
        return false;
      }

      final data = jsonDecode(response.body);

      final newAccessToken = data['access'];
      final newRefreshToken = data['refresh'];

      if (newAccessToken is! String || newRefreshToken is! String) {
        await tokenStorage.clearTokens();
        return false;
      }

      await tokenStorage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      return true;
    } on SocketException {
      return false;
    } on http.ClientException {
      return false;
    } on TimeoutException {
      return false;
    } on FormatException {
      return false;
    }
  }
}
