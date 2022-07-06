import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  Widget _buildDrawer(String title, IconData icon, Function navigateTo) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        navigateTo();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Shop App'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          _buildDrawer("Shop", Icons.shop, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          _buildDrawer("Orders", Icons.payment, () {
            Navigator.of(context).pushNamed(OrdersScreen.routeName);
          })
        ],
      ),
    );
  }
}
