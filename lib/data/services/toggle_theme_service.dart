import 'package:flutter/material.dart';

class ThemeToggleService with ChangeNotifier {
  //theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  bool isDark = false;

  void isToggle() {
    isDark = !isDark;
    notifyListeners();
  }
}
