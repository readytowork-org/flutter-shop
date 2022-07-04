import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String? id;
  final String? title;
  final String? description;
  final String? imageUrl;

  ProductItem(this.id, this.title, this.description, this.imageUrl, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        title: Text(title!),
        leading: const Icon(Icons.favorite),
        backgroundColor: Colors.black54,
        trailing: const Icon(Icons.shopping_cart),
      ),
      child: Image.network(
        imageUrl!,
        fit: BoxFit.cover,
      ),
    );
  }
}
