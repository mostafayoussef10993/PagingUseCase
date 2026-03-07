import 'package:pagnation_usecase/products/models/product_model.dart';
import 'package:pagnation_usecase/products/provider/prod_api_service.dart';

class ProductRepository {
  final ProductApiService api;

  ProductRepository(this.api);

  Future<Map<String, dynamic>> fetchProducts(String? cursor) async {
    final response = await api.fetchProducts(cursor);

    final data = response.data;

    final products = (data['data'] as List)
        .map((e) => Product.fromJson(e))
        .toList();

    return {"products": products, "cursor": data['meta']?['next_cursor']};
  }
}
