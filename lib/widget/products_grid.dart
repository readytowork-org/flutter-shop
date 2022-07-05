import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavourite;

  ProductsGrid(this.showOnlyFavourite);

  @override
  Widget build(BuildContext context) {
    print(showOnlyFavourite);
    final productsData = Provider.of<ProductsProvider>(context);
    final products = showOnlyFavourite ? productsData.favouriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider.value(
          value: products[i], //use this if items are part of list or grid
          // create: (c) => products[i],
          child: ProductItem(),
        );
      },
      itemCount: products.length,
    );
  }
}
