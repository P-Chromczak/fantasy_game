import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../exceptions/network_exception.dart';

class ApiClient {
  final String baseUrl;

  ApiClient({
    required this.baseUrl,
  });

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl$endpoint'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(
            const Duration(seconds: 20),
          );

      return response;
    } on SocketException {
      throw NetworkException(
        'Unable to connect to the server. '
        'Please check your internet connection.',
      );
    } on http.ClientException {
      throw NetworkException(
        'Unable to connect to the server. '
        'Please check your internet connection.',
      );
    } on TimeoutException {
      throw NetworkException(
        'The server did not respond in time. '
        'Please try again later.',
      );
    } on FormatException {
      throw NetworkException(
        'Invalid server address.',
      );
    }
  }
}