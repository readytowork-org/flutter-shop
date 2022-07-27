import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/custom_route.dart';
import '../providers/auth.dart';
import '../screens/user_product_screen.dart';
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
          const Divider(),
          _buildDrawer("Orders", Icons.payment, () {
            // Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            Navigator.of(context).pushReplacement(
              CustomRoute(
                builder: (ctx) => const OrdersScreen(),
              ),
            );
          }),
          const Divider(),
          _buildDrawer("Manage Products", Icons.edit, () {
            Navigator.of(context)
                .pushReplacementNamed(UserProductScreen.routeName);
          }),
          const Divider(),
          _buildDrawer("Logout", Icons.exit_to_app, () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
            Provider.of<Auth>(context, listen: false).logout();
          }),
          const Divider(),
        ],
      ),
    );
  }
}
