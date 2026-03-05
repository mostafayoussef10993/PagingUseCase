import 'package:dio/dio.dart';
import 'package:pagnation_usecase/helper/api/api_error_handler.dart';
import 'package:pagnation_usecase/helper/api/api_result.dart';
import 'package:pagnation_usecase/login/models/login_response.dart';
import 'package:pagnation_usecase/helper/api/api_constants.dart';

// This class is responsible for making API calls related to authentication, such as login.

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<ApiResult<LoginResponse>> login({
    required String identifier,
    required String password,
    required String type,
  }) {
    return ApiErrHandler.handleRequest<LoginResponse>(
      () => _dio.post(
        ApiConstants.loginEndpoint,
        data: {
          ApiConstants.identifierKey: identifier,
          ApiConstants.passwordKey: password,
          ApiConstants.typeKey: type,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      ),
      (json) => LoginResponse.fromJson(json),
    );
  }
}
