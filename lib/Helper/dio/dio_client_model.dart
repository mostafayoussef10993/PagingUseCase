import 'package:dio/dio.dart';
import 'package:pagnation_usecase/helper/dio/dio_logger.dart';
import 'package:pagnation_usecase/helper/secure_storage_service.dart';

class DioClient {
  static Dio create(String baseUrl, {void Function()? onUnauthorized}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 12),
        headers: {'Accept': 'application/json'},
      ),
    );

    setupDioLogger(dio);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageService().getAccessToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            await SecureStorageService().clearAll();
            onUnauthorized?.call();
          }

          return handler.next(error);
        },
      ),
    );

    return dio;
  }
}
