import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color _seedColor = Color.fromARGB(255, 12, 54, 151);
  bool _appBrightness = true;

  Color get seedColor => _seedColor;
  bool get appBrightness => _appBrightness;

  void onChangedThemeBrightness(bool newBrightness) {
    _appBrightness = newBrightness;
    notifyListeners();
  }

  void onChangedThemeColor(Color newColor) {
    _seedColor = newColor;
    notifyListeners();
  }
}
