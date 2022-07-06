import 'package:flutter/foundation.dart';
import 'dart:developer';
import './cart.dart';

class OrderItem {
  final String? id;
  final double? amount;
  final List<CartItem> products;
  final DateTime? date;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.date,
  });
}

class Order with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        date: DateTime.now(),
      ),
    );
    inspect(_orders);
    notifyListeners();
  }
}
