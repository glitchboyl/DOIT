import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  static const Color navigatorBarColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFFFF),
    darkColor: Color(0xFFFFFFFF),
  );

  static const Color generalBackgroundColor =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFF7F7FA),
    darkColor: Color(0xFFF7F7FA),
  );

  static const Color tabBarColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFFFF),
    darkColor: Color(0xFFFFFFFF),
  );

  static const Color ItemTitleColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF373655),
    darkColor: Color(0xFF373655),
  );

  static const Color ItemTimeColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF868CA3),
    darkColor: Color(0xFF868CA3),
  );
}
