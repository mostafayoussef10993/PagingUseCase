// *** API START

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Function to set up Dio logger
void setupDioLogger(Dio dio) {
  dio.interceptors.add(
    PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 120,
    ),
  );
}

// *** API END
