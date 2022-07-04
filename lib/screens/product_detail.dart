import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);
  static const routeName = "/product-detail";
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    print(id);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
      ),
      body: const Center(
        child: Text("Content goes here"),
      ),
    );
  }
}
