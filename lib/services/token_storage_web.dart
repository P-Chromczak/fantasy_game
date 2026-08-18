import 'package:web/web.dart' as web;

import 'token_storage.dart';

// TODO: Consider moving the refresh/session token to an
// HttpOnly + Secure + SameSite cookie for improved web security.

class TokenStorageWeb implements TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    web.window.sessionStorage.setItem(
      _accessTokenKey,
      accessToken,
    );

    web.window.sessionStorage.setItem(
      _refreshTokenKey,
      refreshToken,
    );
  }

  @override
  Future<String?> getAccessToken() async {
    return web.window.sessionStorage.getItem(
      _accessTokenKey,
    );
  }

  @override
  Future<String?> getRefreshToken() async {
    return web.window.sessionStorage.getItem(
      _refreshTokenKey,
    );
  }

  @override
  Future<void> clearTokens() async {
    web.window.sessionStorage.removeItem(
      _accessTokenKey,
    );

    web.window.sessionStorage.removeItem(
      _refreshTokenKey,
    );
  }
}