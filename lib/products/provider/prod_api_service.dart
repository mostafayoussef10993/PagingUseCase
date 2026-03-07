import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pagnation_usecase/products/get%20products/get_best_products.dart';
//Handles dio requests

class ProductApiService {
  final Dio dio;

  ProductApiService(this.dio);

  Future<Response> fetchProducts(String? cursor) async {
    try {
      debugPrint("🌐 Requesting products... cursor=$cursor");

      final response = await dio.get(
        GetBestProducts.endpoint,
        queryParameters: GetBestProducts.getQueryParameters(cursor: cursor),
      );

      debugPrint("✅ Response received: ${response.statusCode}");

      return response;
    } on DioException catch (e) {
      debugPrint("❌ Dio error: ${e.message}");
      rethrow;
    }
  }
}
