import 'package:flutter/material.dart';

import '../model/users_login.dart';

class UserLoginProvider with ChangeNotifier {
  UserLogin _userLogin = UserLogin();
  UserLogin get getUserLogin => _userLogin;

  setUserLogin(UserLogin item) {
    _userLogin = item;
    notifyListeners();
  }

  clearUserLogin() {
    _userLogin = UserLogin();
    notifyListeners();
  }
}
