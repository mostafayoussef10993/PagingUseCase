import 'package:flutter/material.dart';
import 'package:pagnation_usecase/products/models/product_model.dart';

//each product card shape

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: product.photo != null && product.photo!.isNotEmpty
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
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
