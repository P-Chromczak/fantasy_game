import 'dart:async';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

class AuthState {
  AuthStatus _status = AuthStatus.unauthenticated;

  final StreamController<AuthStatus> _controller =
      StreamController<AuthStatus>.broadcast();

  AuthStatus get status => _status;

  Stream<AuthStatus> get stream => _controller.stream;

  void setAuthenticated() {
    _status = AuthStatus.authenticated;
    _controller.add(_status);
  }

  void setUnauthenticated() {
    _status = AuthStatus.unauthenticated;
    _controller.add(_status);
  }

  void dispose() {
    _controller.close();
  }
}