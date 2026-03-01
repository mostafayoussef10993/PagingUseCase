import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//instead of shared preferences
// A service class to handle secure storage operations for access and refresh tokens.
class SecureStorageService {
  static const _storage = FlutterSecureStorage();
  static const _accesTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accesTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getAccessToken() async => _storage.read(key: _accesTokenKey);
  Future<String?> getRefreshToken() async =>
      _storage.read(key: _refreshTokenKey);

  //Method to clear stored token , useful for logging out

  Future<void> clearAll() => _storage.deleteAll();
}
