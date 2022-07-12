import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  late bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavouriteStatus() async {
    var oldStatus = isFavourite;
    try {
      final url =
          "https://flutter-course-2ea1b-default-rtdb.asia-southeast1.firebasedatabase.app/products/${id}.json";
      isFavourite = !isFavourite;
      notifyListeners();
      final response = await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            "isFavourite": !isFavourite,
          },
        ),
      );
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
      }
    } catch (e) {
      isFavourite = oldStatus;
      notifyListeners();
      throw e;
    }
  }
}
