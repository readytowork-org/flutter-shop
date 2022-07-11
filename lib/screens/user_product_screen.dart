import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/add_edit_product_screen.dart';
import '../providers/products_provider.dart';
import '../widget/user_product_tile.dart';
import '../widget/drawer.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);
  static const routeName = "/user-product";

  Future<void> _refreshOnPull(BuildContext context) async{
    await Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts();
    // print('refresh on pull down');
  }
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const SideDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshOnPull(context),
        child: ListView.builder(
          itemBuilder: (ctx, i) => Column(
            children: <Widget>[
              UserProductTile(
                id: productData.items[i].id,
                title: productData.items[i].title,
                imageUrl: productData.items[i].imageUrl,
              ),
              const Divider(),
            ],
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
