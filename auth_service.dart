import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login(String email, String password) {
    // Dummy authentication logic
    _isAuthenticated = email == 'user@example.com' && password == 'password';
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
