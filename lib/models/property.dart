import 'package:flutter/widgets.dart';
import 'package:doit/constants/styles.dart';

class Property {
  const Property({
    required this.icon,
    this.color = Styles.DeactivedColor,
    required this.text,
  });

  final String icon;
  final Color color;
  final String text;
}