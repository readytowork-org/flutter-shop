import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'dart:developer';
import './cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String? id;
  final double? amount;
  final List<CartItem> products;
  final DateTime? date;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.date
  });
}

class Order with ChangeNotifier {
  late List<OrderItem> _orders =[];
  final String? token;
  final String? userId;

  Order(this.token, this._orders,this.userId );

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    // inspect(token);
    final dateTime = DateTime.now();
    final url =
        "https://flutter-course-2ea1b-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$token";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            "amount": total,
            "date": dateTime.toIso8601String(),
            "products": cartProducts
                .map((item) => {
                      "id": item.id,
                      "title": item.title,
                      "quantity": item.quantity,
                      "price": item.price,
                    })
                .toList(),
          },
        ),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)["name"],
          amount: total,
          products: cartProducts,
          date: DateTime.now(),
        ),
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> getOrder() async {
    final url =
        "https://flutter-course-2ea1b-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$token";
    try {
      final response = await http.get(Uri.parse(url));
      final List<OrderItem> loadedOrders = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }

      extractedData.forEach((key, value) {
        loadedOrders.add(OrderItem(
            id: key,
            amount: value['amount'],
            products: (value['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price'],
                  ),
                )
                .toList(),
            date: DateTime.parse(value['date'])));
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
