import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);
  static const routeName = "/product-detail";
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<ProductsProvider>(
      context,
      listen: false, //do not rebuild widgit if Product list changes I.E added, edited, deletedd. Default set to true
    ).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
      ),
      body: const Center(
        child: Text("Content goes here"),
      ),
    );
  }
}
