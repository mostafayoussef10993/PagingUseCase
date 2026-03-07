import 'package:flutter/material.dart';
import 'package:pagnation_usecase/products/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'product_card.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
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
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        // 1. Initial loading
        if (provider.isLoading && provider.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Error state
        if (provider.errorMessage != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
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
          );
        }

        // 3. Empty state
        if (provider.products.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        // 4. Paginated list
        return ListView.builder(
          controller: _scrollController,
          itemCount: provider.products.length + (provider.isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            // Pagination loading spinner at the bottom
            if (index == provider.products.length) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return ProductCard(product: provider.products[index]);
          },
        );
      },
    );
  }
}
