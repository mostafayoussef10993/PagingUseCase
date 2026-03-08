import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pagnation_usecase/helper/api/api_constants.dart';
import 'package:pagnation_usecase/products/constants/products_constants.dart';

// a helper that builds the API request for getting products.
class GetBestProducts {
  static String get endpoint => ApiConstants.productsEndpoint;

  static Map<String, dynamic> getQueryParameters({String? cursor}) => {
    "seller_id": ProductsConstants.sellerId,
    "paginate": ProductsConstants.paginate,
    if (cursor != null) "cursor": cursor,
  };
}

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
