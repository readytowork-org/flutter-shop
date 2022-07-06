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
      listen: false,
      //do not rebuild widgit if Product list changes I.E added,
      //edited, deletedd. Default set to true
    ).findById(id);
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title!),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  product.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                '\$${product.price}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                '${product.description}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
                        SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Add to cart"),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ));
  }
}
