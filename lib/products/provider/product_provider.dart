import 'dart:convert';
import 'dart:developer' as developer;

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
    developer.log('Starting fetchProducts()', name: 'ProductProvider');

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(GetBestProducts.uri);

      developer.log(
        'Response received',
        name: 'ProductProvider',
        error: 'StatusCode: ${response.statusCode}',
      );

      developer.log('Response body: ${response.body}', name: 'ProductProvider');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List productsJson = data['data'];

        developer.log(
          'Products count: ${productsJson.length}',
          name: 'ProductProvider',
        );

        _products = productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        _errorMessage =
            'Failed to load products (status ${response.statusCode})';

        developer.log(_errorMessage!, name: 'ProductProvider', level: 1000);
      }
    } catch (e, stack) {
      _errorMessage = e.toString();

      developer.log(
        'Error fetching products',
        name: 'ProductProvider',
        error: e,
        stackTrace: stack,
        level: 1000,
      );
    } finally {
      _isLoading = false;
      notifyListeners();

      developer.log('fetchProducts() finished', name: 'ProductProvider');
    }
  }
}
