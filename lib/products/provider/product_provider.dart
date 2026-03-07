import 'package:flutter/material.dart';
import 'package:pagnation_usecase/products/models/product_model.dart';
import 'package:pagnation_usecase/products/provider/prod_repository.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository repository;

  ProductProvider(this.repository);

  final List<Product> _products = [];

  bool _isLoading = false;
  bool _hasMoreProducts = true;
  String? _errorMessage;
  String? _nextCursor;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  bool get hasMoreProducts => _hasMoreProducts;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts({bool loadMore = false}) async {
    if (_isLoading) return;

    if (loadMore && !_hasMoreProducts) {
      debugPrint("⚠️ No more products to load");
      return;
    }

    try {
      debugPrint("🚀 Starting product fetch");

      _isLoading = true;
      _errorMessage = null;

      if (!loadMore) {
        _products.clear();
        _nextCursor = null;
      }

      notifyListeners();

      final result = await repository.fetchProducts(_nextCursor);

      final List<Product> newProducts = result["products"];
      final String? cursor = result["cursor"];

      _products.addAll(newProducts);

      _nextCursor = cursor;
      _hasMoreProducts = cursor != null;

      debugPrint("✅ Total products loaded: ${_products.length}");
    } catch (e) {
      _errorMessage = e.toString();

      debugPrint("❌ Provider error: $_errorMessage");
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
