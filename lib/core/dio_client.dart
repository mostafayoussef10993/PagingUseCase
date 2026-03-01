import 'package:dio/dio.dart';
import 'package:pagnation_usecase/core/secure_storage_service.dart';
import 'package:pagnation_usecase/utils/api_endpoints.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
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
        //TODO: I must reedit error handling here , so it can handle token refresh and retry the failed request
        onError: (DioException e, handler) async {
          return handler.next(e);
        },
      ),
    );
  }

  Dio get instance => _dio;
}
