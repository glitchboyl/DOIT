import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  changeTheme(ThemeMode theme) => {
        _themeMode = theme,
        notifyListeners(),
      };
}
