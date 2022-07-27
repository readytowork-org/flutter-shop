import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import '../providers/cart.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  //Method 1: Using provider, this method rebuilds whole widget if Product changes
  @override
  // Widget build(BuildContext context) {
  //   final product = Provider.of<Product>(context);
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(10),
  //     child: GridTile(
  //       footer: GridTileBar(
  //         title: Text(product.title!),
  //         leading: IconButton(
  //           icon: Icon(
  //             product.isFavourite ? Icons.favorite : Icons.favorite_border,
  //           ),
  //           onPressed: () => product.toggleFavouriteStatus(),
  //           color: Theme.of(context).colorScheme.secondary,
  //         ),
  //         backgroundColor: Colors.black87,
  //         trailing: IconButton(
  //           icon: const Icon(Icons.shopping_cart),
  //           onPressed: () {},
  //           color: Theme.of(context).colorScheme.secondary,
  //         ),
  //       ),
  //       child: GestureDetector(
  //         onTap: () {
  //           Navigator.of(context).pushNamed(
  //             ProductDetail.routeName,
  //             arguments: product.id,
  //           );
  //         },
  //         child: Image.network(
  //           product.imageUrl!,
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  //Method 2: Using consumer to rebuild some parts of widget
  //Only icon will rebuild when product changes
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(product.title!),
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () => product.toggleFavouriteStatus(
                authData.token!,
                authData.userId!,
              ),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          backgroundColor: Colors.black87,
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id!, product.price!, product.title!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Item added to your cart."),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      cart.removeSingleItem(product.id.toString());
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetail.routeName,
                arguments: product.id,
              );
            },
            child: Hero(
              tag: product.id!,
              child: FadeInImage(
                placeholder:
                    const AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageUrl!),
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }
}
