import 'package:flutter/material.dart';
import 'package:pagnation_usecase/products/models/product_model.dart';
import 'package:pagnation_usecase/products/provider/product_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final provider = context.read<ProductProvider>();

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      debugPrint("📍 Near bottom - loading more products");
      provider.loadMoreProducts();
    }
  }

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
                child: provider.isLoading && provider.products.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : provider.errorMessage != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Error: ${provider.errorMessage}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : provider.products.isEmpty
                    ? const Center(child: Text("No products found"))
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount:
                            provider.products.length +
                            (provider.isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          // Loading indicator at the end
                          if (index == provider.products.length) {
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

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
