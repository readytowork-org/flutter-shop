import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class Auth with ChangeNotifier {
  String? token;
  DateTime? time;
  String? userId;

  Future<void> signup(String email, String password) async{
    try {
      const url =
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAAisBCWejKaemIPKk1AGZca-PaB3pxhZw";
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {"email": email, "password": password},
        ),
      );
      print(json.decode(response.body));
      return;
    } catch (e) {
      throw e;
    }
  }
}
