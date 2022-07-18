import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class Auth with ChangeNotifier {
  String? token;
  DateTime? time;
  String? userId;
  static const String _appKey = "AIzaSyAAisBCWejKaemIPKk1AGZca-PaB3pxhZw";

  _authenticate(String email, String password, String urlSegment) async {
    try {
      final url =
          "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$_appKey";
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      print(json.decode(response.body));
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}
