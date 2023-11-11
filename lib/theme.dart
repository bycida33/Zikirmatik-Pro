import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  bool get isLightMode => themeMode == ThemeMode.light;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(),
    primaryColor: Colors.black12,
    accentColor: Colors.white,
    backgroundColor: Colors.black,
    appBarTheme: AppBarTheme(backgroundColor: Colors.black),
    iconTheme: IconThemeData(color: Colors.white),
  );
  static final lightTheme = ThemeData(
      colorScheme: ColorScheme.light(),
      primaryColor: Colors.white,
      accentColor: Colors.black,
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      iconTheme: IconThemeData(color: Colors.black));
}
