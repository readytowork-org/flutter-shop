import 'package:flutter/material.dart';

class UserProductTile extends StatelessWidget {
  final String? title;
  final String? imageUrl;

  const UserProductTile({
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
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
          IconButton(
            onPressed: () {},
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
