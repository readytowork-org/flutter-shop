import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductOverViewScreen extends StatelessWidget {
  const ProductOverViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product overview screen"),
      ),
      body: Center(
        child: Text("Content goes here"),
      ),
    );
  }
}
