// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:pagnation_usecase/products/widgets/fetch_products_button.dart';
import 'package:pagnation_usecase/products/widgets/products_listview.dart';

class HomeScreen extends StatelessWidget {
  // No longer needs StatefulWidget!
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Best Seller Products")),
      body: const Column(
        children: [
          FetchButton(),
          Expanded(child: ProductListView()),
        ],
      ),
    );
  }
}
