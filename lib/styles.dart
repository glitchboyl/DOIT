import 'package:flutter/cupertino.dart';

abstract class Styles {
  static const Color NavigatorBarColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFFFF),
    darkColor: Color(0xFFFFFFFF),
  );

  static const Color GeneralBackgroundColor =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFF7F7FA),
    darkColor: Color(0xFFF7F7FA),
  );

  static const Color TabBarColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFFFF),
    darkColor: Color(0xFFFFFFFF),
  );

  static const Color ToDoItemTitleColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF373655),
    darkColor: Color(0xFF373655),
  );

  static const Color ToDoItemTimeColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF868CA3),
    darkColor: Color(0xFF868CA3),
  );

  static const Color ToDoItemRemarksColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF868CA3),
    darkColor: Color(0xFF868CA3),
  );

  static const Color AddToDoItemButtonColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF3A36EE),
    darkColor: Color(0xFF3A36EE),
  );

  static const Color AddToDoItemButtonShadowColor = CupertinoDynamicColor.withBrightness(
    color: Color(0x33312DE0),
    darkColor: Color(0x33312DE0),
  );
}
