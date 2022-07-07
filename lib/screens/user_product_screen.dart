import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widget/user_product_tile.dart';
import '../widget/drawer.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);
  static const routeName = "/user-product";
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const SideDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => UserProductTile(
          title: productData.items[i].title,
          imageUrl: productData.items[i].imageUrl,
        ),
        itemCount: productData.items.length,
      ),
    );
  }
}
