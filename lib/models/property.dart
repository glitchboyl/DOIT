import 'package:flutter/widgets.dart';

class Property {
  const Property({
    required this.icon,
    required this.color,
    required this.text,
  });

  final String icon;
  final Color Function(BuildContext) color;
  final String text;
}
