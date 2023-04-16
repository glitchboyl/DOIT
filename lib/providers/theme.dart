import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  changeTheme(ThemeMode theme) => {
        _themeMode = theme,
        notifyListeners(),
      };
}

bool isDarkMode(BuildContext context) {
  final themeMode = Provider.of<ThemeProvider>(
    context,
    listen: false,
  ).themeMode;
  return themeMode == ThemeMode.dark ||
      (themeMode == ThemeMode.system
              ? SchedulerBinding.instance.window.platformBrightness
              : Theme.of(context).brightness) ==
          Brightness.dark;
}
