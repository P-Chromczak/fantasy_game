import 'token_storage.dart';
import 'token_storage_mobile.dart'

    if (dart.library.js_interop) 'token_storage_web.dart'
    as platform;

TokenStorage createTokenStorage() {
  return platform.createTokenStorage();
}
