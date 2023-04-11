import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Barlow',
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    applyElevationOverlayColor: false,
    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: LightStyles.BackgroundColor,
    primaryColor: LightStyles.PrimaryColor,
    colorScheme: ColorScheme.light(
      primary: LightStyles.PrimaryColor,
      onPrimary: LightStyles.PrimaryTextColor,
    ),
  );

  static ThemeData darkTheme = lightTheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DarkStyles.BackgroundColor,
    primaryColor: DarkStyles.PrimaryColor,
    colorScheme: ColorScheme.dark(
      primary: DarkStyles.PrimaryColor,
      onPrimary: DarkStyles.PrimaryTextColor,
    ),
  );
}
