import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../screens/add_edit_product_screen.dart';

class UserProductTile extends StatelessWidget {
  final String? id;
  final String? title;
  final String? imageUrl;

  const UserProductTile({
    required this.id,
    required this.title,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl!),
      ),
      title: Text(title!),
      trailing: SizedBox(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AddEditProductScreen.routeName, arguments: id);
            },
            icon: const Icon(
              Icons.edit,
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
          IconButton(
            onPressed: () {
              Provider.of<ProductsProvider>(context, listen: false)
                  .deleteProduct(id!);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Item added to your cart."),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
            ),
            color: Theme.of(context).colorScheme.primary,
          )
        ]),
      ),
    );
  }
}
