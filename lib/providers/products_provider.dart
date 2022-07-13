import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  late List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((item) => item.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> addProduct(Product product) async {
    const url =
        "https://flutter-course-2ea1b-default-rtdb.asia-southeast1.firebasedatabase.app/products.json";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            "title": product.title,
            "price": product.price,
            "description": product.description,
            "isFavourite": product.isFavourite,
            "imageUrl": product.imageUrl
          },
        ),
      );
      inspect(response);
      final newProduct = Product(
        id: json.decode(response.body)["name"],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      // inspect(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product updateProduct) async {
    try {
      final url =
          "https://flutter-course-2ea1b-default-rtdb.asia-southeast1.firebasedatabase.app/products/${id}.json";
      final response = await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            "title": updateProduct.title,
            "price": updateProduct.price,
            "description": updateProduct.description,
            "imageUrl": updateProduct.imageUrl,
          },
        ),
      );
      final prodIndex = _items.indexWhere((item) => item.id == id);
      if (prodIndex >= 0) {
        _items[prodIndex] = updateProduct;
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        "https://flutter-course-2ea1b-default-rtdb.asia-southeast1.firebasedatabase.app/products/${id}.json";
    final productIndex = _items.indexWhere((item) => item.id == id);
    var existingProduct = _items[productIndex];

    _items.removeAt(productIndex);
    notifyListeners();

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode >= 400) {
      _items.insert(productIndex, existingProduct);
      notifyListeners();
      HttpException('Cannot delete product');
    }
    existingProduct = null as Product;

    // _items.removeWhere((item) => item.id == id);
    // notifyListeners();
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        "https://flutter-course-2ea1b-default-rtdb.asia-southeast1.firebasedatabase.app/products.json";
    try {
      final response = await http.get(Uri.parse(url));
      final loadedProducts = json.decode(response.body) as Map<String, dynamic>?;
      if (loadedProducts == null) {
        return;
      }
      final List<Product> decodedProduct = [];
      loadedProducts.forEach((prodId, productData) {
        decodedProduct.add(Product(
          id: prodId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavourite: productData['isFavourite']
        ));
      });
      _items = decodedProduct;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
