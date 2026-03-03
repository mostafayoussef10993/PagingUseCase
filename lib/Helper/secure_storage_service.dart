import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pagnation_usecase/login/models/user.dart';

//instead of shared preferences
// A service class to handle secure storage operations for access and refresh tokens.
class SecureStorageService {
  static const _storage = FlutterSecureStorage();
  static const _accesTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userKey = 'user';

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

  //User data is stored

  Future<void> saveUser(User user) async {
    await _storage.write(key: _userKey, value: jsonEncode(user.toJson()));
  }

  //Retrieving user data from secure storage
  Future<User?> getUser() async {
    final jsonStr = await _storage.read(key: _userKey);
    if (jsonStr == null) return null;
    final Map<String, dynamic> map = jsonDecode(jsonStr);
    return User.fromJson(map);
  }

  //Clearing all stored data, including tokens and user information
  @override
  Future<void> clearAll() => _storage.deleteAll();
}
