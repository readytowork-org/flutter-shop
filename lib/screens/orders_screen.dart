import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/drawer.dart';
import '../widget/order_tile.dart';
import '../providers/Order.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders-screen';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_)  async {
      setState(() {
        _isLoading = true;
      });
      await  Provider.of<Order>(context, listen: false).getOrder();
      setState(() {
        _isLoading = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your orders"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, i) => OrderTile(
                order: orderData.orders[i],
              ),
              itemCount: orderData.orders.length,
            ),
      drawer: const SideDrawer(),
    );
  }
}
