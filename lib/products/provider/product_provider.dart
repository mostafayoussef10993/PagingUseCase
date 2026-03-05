import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pagnation_usecase/products/http/get_best_products.dart';
import 'package:pagnation_usecase/products/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(GetBestProducts.uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List productsJson = data['data'];
        _products = productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        _errorMessage =
            'Failed to load products (status ${response.statusCode})';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
