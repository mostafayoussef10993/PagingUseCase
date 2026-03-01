import 'package:pagnation_usecase/login/models/user.dart';

class LoginResponse {
  final String tokenType;
  final int expiresIn;
  final String accessToken;
  final String refreshToken;
  final User user;
  final String? message;

  LoginResponse({
    required this.tokenType,
    required this.expiresIn,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      tokenType: json['token_type'] as String? ?? 'Bearer',
      expiresIn: (json['expires_in'] as num?)?.toInt() ?? 0,
      accessToken: json['access_token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
      user: User.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
      message: json['message'] as String?,
    );
  }
}
