import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import "package:shared_preferences/shared_preferences.dart";
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "../models/http_exception.dart";

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expieryTime;
  String? _userId;
  Timer? _authTimer;

  static const String _appKey = "AIzaSyAAisBCWejKaemIPKk1AGZca-PaB3pxhZw";

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null &&
        _expieryTime!.isAfter(DateTime.now()) &&
        _userId != null) {
      return _token!;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

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
      // print(json.decode(response.body['expiresIn']));
      // inspect(json.decode(response.body));
      final responseBody = json.decode(response.body);
      _token = responseBody["idToken"];
      _userId = responseBody["localId"];
      _expieryTime = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody["expiresIn"]),
        ),
      );
      _autoLogout();
      notifyListeners();
      final preference = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expieryTime': _expieryTime!.toIso8601String(),
        },
      );
      await preference.setString("userData", userData);
      if (responseBody["error"] != null) {
        throw HttpException(responseBody["error"]["message"]);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<bool> tryAutoLogin() async {
    final preference = await SharedPreferences.getInstance();
    if (!preference.containsKey('userData')) {
      return false;
    }

    final extractedData =
        json.decode(preference.getString("userData")!) as Map<String, dynamic>;
    final expieryDate = DateTime.parse(extractedData["expieryTime"]);

    if (expieryDate.isBefore(DateTime.now())) {
      return false;
    }
    _expieryTime = expieryDate;
    _token = extractedData['token'];
    _userId = extractedData['userId'];
    _autoLogout();
    return true;
  }

  void logout() {
    _token = null;
    _expieryTime = null;
    _userId = null;

    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToLogout = _expieryTime!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(
      Duration(seconds: timeToLogout),
      logout,
    );
  }
}
