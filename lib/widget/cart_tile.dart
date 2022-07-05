import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final String? id;
  final String? title;
  final int? quantity;
  final double? price;

  const CartTile(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: FittedBox(
                child: Text('\$$price'),
              ),
            ),
          ),
          title: Text(title!),
          subtitle: Text('Total: \$${price! * quantity!}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
