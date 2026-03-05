import 'package:dio/dio.dart';
import 'api_result.dart';

class ApiErrHandler {
  static Future<ApiResult<T>> handleRequest<T>(
    Future<Response> Function() request,
    T Function(dynamic json) fromJson,
  ) async {
    try {
      final response = await request();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = fromJson(response.data);
        return Success(data);
      }

      // if Server returned error status (400, 401, 403, 404, 422, 500…)
      final serverMessage = _extractServerMessage(response.data);
      return Failure(
        serverMessage ?? 'Server error (${response.statusCode})',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      // Handle difference error types
      String message;
      final statusCode = e.response?.statusCode;

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          message =
              'Request timed out. Please check your connection and try again.';
          break;

        case DioExceptionType.connectionError:
        case DioExceptionType.badCertificate:
          message =
              'Cannot connect to server. Please check your internet connection.';
          break;

        case DioExceptionType.cancel:
          message = 'Request was cancelled.';
          break;

        case DioExceptionType.badResponse:
          // Server responded with error status (400–599)
          final serverMsg = _extractServerMessage(e.response?.data);
          if (statusCode == 401 || statusCode == 403) {
            message =
                serverMsg ?? 'Invalid credentials or unauthorized access.';
          } else if (statusCode == 404) {
            message = serverMsg ?? 'Resource not found.';
          } else if (statusCode == 422 || statusCode == 400) {
            message =
                serverMsg ?? 'Invalid data provided. Please check your input.';
          } else if (statusCode != null && statusCode >= 500) {
            message = serverMsg ?? 'Server error — please try again later.';
          } else {
            message =
                serverMsg ??
                'Unexpected server response (${statusCode ?? "unknown"}).';
          }
          break;

        case DioExceptionType.unknown:
          message = e.message != null && e.message!.isNotEmpty
              ? 'Network error: ${e.message}'
              : 'Something went wrong. Please try again.';
          break;
      }

      return Failure(message, statusCode: statusCode);
    } catch (e) {
      // ── Very unexpected errors (bug in fromJson, JSON parsing crash, etc.) ──
      // In production you might want to log this to Crashlytics/Sentry
      return Failure('Unexpected error occurred. Please contact support.');
    }
  }

  /// Helper to extract meaningful message from typical API error responses
  static String? _extractServerMessage(dynamic data) {
    if (data == null) return null;

    if (data is String) return data;

    if (data is Map<String, dynamic>) {
      return data['message'] ??
          data['error'] ??
          data['detail'] ??
          data['msg'] ??
          data['description'];
    }

    return null;
  }
}
