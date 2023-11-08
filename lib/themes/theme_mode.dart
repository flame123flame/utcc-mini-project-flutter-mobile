import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MyThemes {
  final BuildContext context;

  MyThemes(this.context);

  ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: Color(0xff18191b),
      primaryColor: Color.fromARGB(255, 255, 255, 255),
      cardColor: Color(0xff333436),
      hintColor: Color.fromARGB(255, 196, 193, 193),
      dialogBackgroundColor: Color.fromARGB(255, 110, 110, 110),
      colorScheme: ColorScheme.dark(),
      iconTheme: IconThemeData(color: Colors.white, opacity: 0.8),
      fontFamily: 'anuphan',
    );
  }

  ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: Color(0xffeaf3fe),
      primaryColor: Color(0xff333436),
      cardColor: Color.fromARGB(255, 255, 255, 255),
      colorScheme: ColorScheme.light(),
      iconTheme: IconThemeData(color: Color(0xff333436), opacity: 0.8),
      fontFamily: 'anuphan',
    );
  }
}

class ThemeProviderDarkModeAndLight extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode != ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
