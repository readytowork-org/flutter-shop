import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/drawer.dart';
import '../widget/order_tile.dart';
import '../providers/Order.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your orders"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderTile(
          order: orderData.orders[i],
        ),
        itemCount: orderData.orders.length,
      ),
      drawer: const SideDrawer(),
    );
  }
}
