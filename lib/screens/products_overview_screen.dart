import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import '../widget/drawer.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../widget/badge.dart';
import '../widget/products_grid.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverViewScreen extends StatefulWidget {
  const ProductsOverViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  var _showOnlyFavourite = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    //alternative to didChangeDependencies
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    // });
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Products"),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _showOnlyFavourite = true;
                } else {
                  _showOnlyFavourite = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favourites,
                child: Text('Only Favourites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show All'),
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              value: cart.cartItemCount.toString(),
              child: child
                  as Widget, //child will take Icon button from below child
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: _isLoading? const CircularProgressIndicator(): ProductsGrid(_showOnlyFavourite),
      drawer: const SideDrawer(),
    );
  }
}
