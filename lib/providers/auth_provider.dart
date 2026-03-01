import 'package:flutter/material.dart';
import 'package:pagnation_usecase/core/dio_client.dart';
import 'package:pagnation_usecase/core/secure_storage_service.dart';
import 'package:pagnation_usecase/data/auth_remote_data_source.dart';
import 'package:pagnation_usecase/models/user.dart';

//TODO: Naming
// note: logic, usecase, provider. viewmodel =====> we do all the logic
class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isInitialized = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  String? get errorMessage => _errorMessage;
  bool get isInitialized => _isInitialized;

  final _storage = SecureStorageService();
  late final AuthRemoteDataSource _dataSource;

  AuthProvider() {
    _dataSource = AuthRemoteDataSource(DioClient().instance);
    _loadSession();
  }

  Future<void> _loadSession() async {
    try {
      final token = await _storage.getAccessToken();

      if (token != null) {
        _user = null;
      }
    } catch (e) {
      // silent fail
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<bool> login({
    required String identifier,
    required String password,
    required String type,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _dataSource.login(
        identifier: identifier,
        password: password,
        type: type,
      );

      await _storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      _user = response.user;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _storage.clearAll();
    _user = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
