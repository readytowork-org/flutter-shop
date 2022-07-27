import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
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
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(product.title!),
            background: Hero(
              tag: product.id!,
              child: Image.network(
                product.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate(
          [
            const SizedBox(
              height: 16,
            ),
            Text(
              '\$${product.price}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            Column(
              children: <Widget>[
                ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart),
                label: const Text("Add to cart"),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  Provider.of<Cart>(context, listen: false)
                      .addItem(product.id!, product.price!, product.title!);
                },
              ),
              ],
            ),
            const SizedBox(
              height: 500,
            )
          ],
        )),
      ],
    ));
  }
}
