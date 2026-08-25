import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../exceptions/network_exception.dart';
import '../services/token_refresh_service.dart';
import '../services/token_storage.dart';
import '../services/auth_state.dart';

class ApiClient {
  final String baseUrl;
  final TokenStorage tokenStorage;
  late final TokenRefreshService tokenRefreshService;
  final AuthState authState;

  ApiClient({
    required this.baseUrl,
    required this.tokenStorage,
    required this.authState,

  }) {
    tokenRefreshService = TokenRefreshService(
      baseUrl: baseUrl,
      tokenStorage: tokenStorage,
      authState: authState,
      
    );
  }

  Future<Map<String, String>> _buildHeaders({
    bool authenticated = false,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (authenticated) {
      final accessToken = await tokenStorage.getAccessToken();

      if (accessToken != null) {
        headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    return headers;
  }

  Future<http.Response> _sendPost(
    String endpoint, {
    Map<String, dynamic>? body,
    bool authenticated = false,
  }) async {
    final headers = await _buildHeaders(
      authenticated: authenticated,
    );

    return http
        .post(
          Uri.parse('$baseUrl$endpoint'),
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(const Duration(seconds: 20));
  }

  Future<http.Response> _sendGet(
    String endpoint, {
    bool authenticated = false,
  }) async {
    final headers = await _buildHeaders(
      authenticated: authenticated,
    );

    return http
        .get(
          Uri.parse('$baseUrl$endpoint'),
          headers: headers,
        )
        .timeout(const Duration(seconds: 20));
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    bool authenticated = false,
  }) async {
    try {
      var response = await _sendPost(
        endpoint,
        body: body,
        authenticated: authenticated,
      );

      if (authenticated && response.statusCode == 401) {
        final refreshed =
            await tokenRefreshService.refreshAccessToken();

        if (refreshed) {
          response = await _sendPost(
            endpoint,
            body: body,
            authenticated: true,
          );
        }
      }

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

  Future<http.Response> get(
    String endpoint, {
    bool authenticated = false,
  }) async {
    try {
      var response = await _sendGet(
        endpoint,
        authenticated: authenticated,
      );

      if (authenticated && response.statusCode == 401) {
        final refreshed =
            await tokenRefreshService.refreshAccessToken();

        if (refreshed) {
          response = await _sendGet(
            endpoint,
            authenticated: true,
          );
        }
      }

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