import 'package:dio/dio.dart';
import 'package:pagnation_usecase/products/get%20products/get_best_products.dart';
//Handles dio requests

class ProductApiService {
  final Dio dio;
  ProductApiService(this.dio);
  Future<Response> fetchProducts(String? cursor) {
    return dio.get(
      GetBestProducts.endpoint,
      queryParameters: GetBestProducts.getQueryParameters(cursor: cursor),
    );
  }
}
