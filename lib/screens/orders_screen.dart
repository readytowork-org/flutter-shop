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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your orders"),
      ),
      body: FutureBuilder(
        future: Provider.of<Order>(context, listen: false).getOrder(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapShot.error != null) {
              return const Center(child: Text('An error occurred'));
            } else {
              return Consumer<Order>(
                builder: (context, orderData, child) => ListView.builder(
                  itemBuilder: (ctx, i) => OrderTile(
                    order: orderData.orders[i],
                  ),
                  itemCount: orderData.orders.length,
                ),
              );
            }
          }
        },
      ),
      // ,_isLoading
      //     ? const Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : ListView.builder(
      //         itemBuilder: (ctx, i) => OrderTile(
      //           order: orderData.orders[i],
      //         ),
      //         itemCount: orderData.orders.length,
      //       ),
      drawer: const SideDrawer(),
    );
  }
}
