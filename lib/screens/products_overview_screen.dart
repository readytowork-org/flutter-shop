import 'package:flutter/material.dart';
import 'package:shop_app/widget/products_grid.dart';

class ProductsOverViewScreen extends StatelessWidget {
  const ProductsOverViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Our Products"),
        ),
        body: const ProductsGrid());
  }
}
