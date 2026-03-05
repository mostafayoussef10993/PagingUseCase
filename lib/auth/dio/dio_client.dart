/*import 'package:dio/dio.dart';
import 'package:pagnation_usecase/helper/secure_storage_service.dart';
import 'package:pagnation_usecase/helper/api/api_constants.dart';

class DioClient {
  final void Function()? onUnauthorized;
  late final Dio _dio;

  DioClient({this.onUnauthorized}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.authbaseUrl,
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 12),
        headers: {'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageService().getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          final statusCode = e.response?.statusCode;
          // Check for unauthorized status codes
          if (statusCode == 401 || statusCode == 403) {
            // Clear tokens and user data
            await SecureStorageService().clearAll();
            onUnauthorized?.call();
          }
          return handler.next(e);
        },
      ),
    );
  }

  Dio get instance => _dio;
}*/
