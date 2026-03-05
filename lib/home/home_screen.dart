import 'package:flutter/material.dart';
import 'package:pagnation_usecase/products/models/product_model.dart';
import 'package:pagnation_usecase/products/provider/product_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Best Seller Products")),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  debugPrint("🔵 Button pressed -> Starting API call");

                  try {
                    await provider.fetchProducts();

                    debugPrint("✅ API call finished successfully");
                    debugPrint(
                      "📦 Products count: ${provider.products.length}",
                    );
                  } catch (e, stackTrace) {
                    debugPrint("❌ Error while fetching products: $e");
                    debugPrint("📍 StackTrace: $stackTrace");
                  }

                  debugPrint("🔚 Button press process finished");
                },
                child: const Text("Get Products"),
              ),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.products.isEmpty
                    ? const Center(child: Text("No products found"))
                    : ListView.builder(
                        itemCount: provider.products.length,
                        itemBuilder: (context, index) {
                          final Product product = provider.products[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: ListTile(
                              leading:
                                  product.photo != null &&
                                      product.photo!.isNotEmpty
                                  ? Image.network(
                                      product.photo!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.image),
                              title: Text(product.title ?? "Untitled"),
                              subtitle: Text(
                                "Price: ${product.price ?? 0}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
