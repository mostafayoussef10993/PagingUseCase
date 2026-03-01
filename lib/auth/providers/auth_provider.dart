import 'package:flutter/material.dart';
import 'package:pagnation_usecase/Helper/api_result.dart';
import 'package:pagnation_usecase/Helper/dio_client.dart';
import 'package:pagnation_usecase/Helper/secure_storage_service.dart';
import 'package:pagnation_usecase/auth/auth_remote_data_source.dart';
import 'package:pagnation_usecase/login/models/login_response.dart';
import 'package:pagnation_usecase/login/models/user.dart';

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
  // check if there is a valid session (token) on app start
  Future<void> _loadSession() async {
    try {
      final token = await _storage.getAccessToken();

      //ignore saved tokens

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

    final result = await _dataSource.login(
      identifier: identifier,
      password: password,
      type: type,
    );

    if (result is Success<LoginResponse>) {
      final response = result.data;

      await _storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      _user = response.user;
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } else if (result is Failure<LoginResponse>) {
      _errorMessage = result.message;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  //log out by clearing tokens and user data
  Future<void> logout() async {
    await _storage.clearAll();
    _user = null;
    notifyListeners();
  }
  // Clear error message (e.g., when user starts editing form again)

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
