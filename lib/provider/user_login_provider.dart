import 'package:flutter/material.dart';

import '../model/users_login.dart';

class UserLoginProvider with ChangeNotifier {
  UserLogin _userLogin = UserLogin();
  UserLogin get getUserLogin => _userLogin;

  setUserLogin(UserLogin item) {
    _userLogin = item;
    notifyListeners();
  }

  editUser(
    String firstName,
    String lastName,
    String position,
    String phoneNumber,
    String email,
  ) {
    _userLogin.firstName = firstName;
    _userLogin.lastName = lastName;
    _userLogin.position = position;
    _userLogin.phoneNumber = phoneNumber;
    _userLogin.email = email;
    notifyListeners();
  }

  clearUserLogin() {
    _userLogin = UserLogin();
    notifyListeners();
  }
}
