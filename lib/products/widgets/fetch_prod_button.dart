// widgets/fetch_button.dart
import 'package:flutter/material.dart';
import 'package:pagnation_usecase/products/provider/product_provider.dart';
import 'package:provider/provider.dart';
//Button to fetch products in home screen

class FetchButton extends StatelessWidget {
  const FetchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final provider = context.read<ProductProvider>();
        debugPrint("🔵 Button pressed -> Starting API call");
        try {
          await provider.fetchProducts();
          debugPrint("✅ API call finished successfully");
          debugPrint("📦 Products count: ${provider.products.length}");
        } catch (e, stackTrace) {
          debugPrint("❌ Error while fetching products: $e");
          debugPrint("📍 StackTrace: $stackTrace");
        }
        debugPrint("🔚 Button press process finished");
      },
      child: const Text("Get Products"),
    );
  }
}
