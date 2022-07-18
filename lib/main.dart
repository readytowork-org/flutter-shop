import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**Screens */
import './screens/add_edit_product_screen.dart';
import './screens/user_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/cart_screen.dart';
import './screens/auth_screen.dart';

/**Providers */
import './providers/cart.dart';
import './providers/products_provider.dart';
import './providers/Order.dart';
import './providers/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ProductsProvider(), //use this if new object is created based on class to avoid bugs and efficency
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Order(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.orange),
            textTheme:
                const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
            fontFamily: 'Lato'),
        home: AuthScreen(),
        routes: {
          ProductsOverViewScreen.routeName: (context) =>
              const ProductsOverViewScreen(),
          ProductDetail.routeName: (context) => const ProductDetail(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          UserProductScreen.routeName: (context) => const UserProductScreen(),
          AddEditProductScreen.routeName: (context) =>
              const AddEditProductScreen()
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop app"),
      ),
      body: const Center(
        child: Text("Content goes here"),
      ),
    );
  }
}
