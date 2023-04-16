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

bool isDarkMode(BuildContext context) =>
    (Provider.of<ThemeProvider>(
          context,
          listen: false,
        ).themeMode ==
        ThemeMode.dark) ||
    (SchedulerBinding.instance.window.platformBrightness == Brightness.dark) ||
    (Theme.of(context).brightness == Brightness.dark);
