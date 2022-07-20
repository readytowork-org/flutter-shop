import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order.dart';
import '../widget/cart_tile.dart';
import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart-screen";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                inspect(cart);
                return CartTile(
                  id: cart.items.values.toList()[i].id,
                  productId: cart.items.keys.toList()[i],
                  title: cart.items.values.toList()[i].title,
                  quantity: cart.items.values.toList()[i].quantity,
                  price: cart.items.values.toList()[i].price,
                );
              },
              itemCount: cart.items.length,
            ),
          ),
          OrderButton(cart: cart),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 120,
      margin: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
        ),
        onPressed: widget.cart.totalAmount <= 0 || _isLoading
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                // ignore: await_only_futures
                await Provider.of<Order>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(),
                  widget.cart.totalAmount,
                );
                widget.cart.clearCart();
                setState(() {
                  _isLoading = false;
                });
              },
        child: _isLoading
            ? const CircularProgressIndicator()
            : const Text(
                'Checkout',
                style: TextStyle(fontSize: 16),
              ),
      ),
    );
  }
}
