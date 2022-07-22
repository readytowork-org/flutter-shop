import 'dart:convert';
import 'dart:developer';

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

  void _setFavStatus(bool newValue){
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    var oldStatus = isFavourite;

    final url =
        "https://flutter-course-2ea1b-default-rtdb.asia-southeast1.firebasedatabase.app/userFavourites/$userId/$id.json?auth=$token";
    isFavourite = !isFavourite;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse(url),
        body: json.encode(isFavourite),
      );
      if (response.statusCode >= 400) {
        _setFavStatus(isFavourite);
      }
    } catch (e) {
      _setFavStatus(oldStatus);
      throw e;
    }
  }
}
