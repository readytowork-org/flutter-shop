import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/Order.dart';

class OrderTile extends StatelessWidget {
  final OrderItem order;
  const OrderTile({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      print(order);
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text('\$${order.amount}'),
          subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm').format(order.date as DateTime),
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.expand_more,
              )),
        ),
      ),
    );
  }
}
