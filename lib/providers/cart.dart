import 'package:flutter/foundation.dart';
import 'dart:developer'; //for debug purpose only

class CartItem {
  final String? id;
  final String? title;
  final int? quantity;
  final double? price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get cartItemCount {
    var total = 0;
    _items.forEach((key, item) {
      total += item.quantity!;
    });
    return total;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, item) {
      total += item.price! * item.quantity!;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingProduct) => CartItem(
          id: existingProduct.id,
          title: existingProduct.title,
          quantity: existingProduct.quantity! + 1,
          price: existingProduct.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    // inspect(_items);

    notifyListeners();
  }

  void removeItemFromCart(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity! > 1) {
      _items.update(
          productId,
          (existingProduct) => CartItem(
                id: existingProduct.id,
                title: existingProduct.title,
                quantity: existingProduct.quantity! - 1,
                price: existingProduct.price,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
