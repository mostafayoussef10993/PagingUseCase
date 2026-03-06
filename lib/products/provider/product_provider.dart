import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pagnation_usecase/helper/api/api_constants.dart';
import 'package:pagnation_usecase/helper/dio/dio_client_model.dart';
import 'package:pagnation_usecase/products/http/get_best_products.dart';
import 'package:pagnation_usecase/products/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _nextCursor;
  bool _hasMoreProducts = true;
  late final Dio _dio;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasMoreProducts => _hasMoreProducts;

  ProductProvider() {
    _dio = DioClient.create(ApiConstants.prodbaseUrl);
  }

  Future<void> fetchProducts({bool loadMore = false}) async {
    if (loadMore && _nextCursor == null) {
      debugPrint("⚠️ No more products to load");
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    if (!loadMore) {
      _products = [];
      _nextCursor = null;
    }
    notifyListeners();

    try {
      debugPrint(
        "🌐 Fetching from: ${ApiConstants.prodbaseUrl}${GetBestProducts.endpoint}",
      );

      final response = await _dio.get(
        GetBestProducts.endpoint,
        queryParameters: GetBestProducts.getQueryParameters(
          cursor: _nextCursor,
        ),
      );

      debugPrint("📊 Response status: ${response.statusCode}");
      debugPrint("📄 Response data: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint("✅ Decoded JSON: $data");

        if (data is Map && data.containsKey('data')) {
          final List productsJson = data['data'];
          debugPrint("📦 Products array length: ${productsJson.length}");

          final newProducts = productsJson.map((json) {
            try {
              debugPrint("🔍 Product JSON: $json");
              return Product.fromJson(json);
            } catch (e, stackTrace) {
              debugPrint("❌ Error parsing product: $e");
              debugPrint("📍 StackTrace: $stackTrace");
              rethrow;
            }
          }).toList();

          _products.addAll(newProducts);

          // Handle cursor pagination
          if (data.containsKey('meta') && data['meta'] is Map) {
            _nextCursor = data['meta']['next_cursor'];
            _hasMoreProducts = _nextCursor != null;
            debugPrint("📍 Next cursor: $_nextCursor");
            debugPrint("➡️ Has more products: $_hasMoreProducts");
          }

          debugPrint(
            "✅ Successfully mapped ${_products.length} total products",
          );
        } else {
          _errorMessage = 'Unexpected response format: data field not found';
          debugPrint("❌ Response format error: $data");
        }
      } else {
        _errorMessage =
            'Failed to load products (status ${response.statusCode})';
      }
    } on DioException catch (e) {
      _errorMessage = 'Error: ${e.message}';
      debugPrint("❌ DioException: $e");
      debugPrint("📍 Response: ${e.response}");
    } catch (e, stackTrace) {
      _errorMessage = 'Error: $e';
      debugPrint("❌ Exception: $e");
      debugPrint("📍 StackTrace: $stackTrace");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreProducts() async {
    if (_hasMoreProducts && !_isLoading) {
      await fetchProducts(loadMore: true);
    }
  }
}
