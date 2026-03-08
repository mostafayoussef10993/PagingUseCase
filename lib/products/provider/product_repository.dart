import 'package:flutter/material.dart';
import 'package:pagnation_usecase/products/models/product_model.dart';
import 'package:pagnation_usecase/products/provider/product_api_service.dart';
// handles data parsing

class ProductRepository {
  final ProductApiService api;

  ProductRepository(this.api);

  Future<Map<String, dynamic>> fetchProducts(String? cursor) async {
    try {
      final response = await api.fetchProducts(cursor);

      if (response.statusCode != 200) {
        throw Exception("API failed with ${response.statusCode}");
      }

      final data = response.data;

      debugPrint("📦 Parsing products...");

      final products = (data['data'] as List)
          .map((json) => Product.fromJson(json))
          .toList();

      final nextCursor = data['meta']?['next_cursor'];

      debugPrint("➡️ Next cursor: $nextCursor");

      return {"products": products, "cursor": nextCursor};
    } catch (e) {
      debugPrint("❌ Repository error: $e");
      rethrow;
    }
  }
}
