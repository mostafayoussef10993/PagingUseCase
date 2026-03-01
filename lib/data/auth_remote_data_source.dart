import 'package:dio/dio.dart';
import 'package:pagnation_usecase/models/login_response.dart';
import 'package:pagnation_usecase/utils/api_endpoints.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<LoginResponse> login({
    required String identifier,
    required String password,
    required String type,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.loginEndpoint,
        data: {
          ApiConstants.identifierKey: identifier,
          ApiConstants.passwordKey: password,
          ApiConstants.typeKey: type,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      //TODO: base model (if result == success)
      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Network error: ${e.message}',
      );
    }
  }
}
