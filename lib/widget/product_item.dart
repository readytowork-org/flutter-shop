import 'package:flutter/material.dart';
import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  final String? id;
  final String? title;
  final String? description;
  final String? imageUrl;

  const ProductItem(this.id, this.title, this.description, this.imageUrl,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(title!),
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
            color: Theme.of(context).colorScheme.secondary,
          ),
          backgroundColor: Colors.black87,
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetail.routeName,
              arguments: id,
            );
          },
          child: Image.network(
            imageUrl!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
