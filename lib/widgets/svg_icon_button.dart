import 'package:flutter/material.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/widgets/svg_icon.dart';

class SVGIconButton extends StatelessWidget {
  const SVGIconButton(
    this.icon, {
    super.key,
    required this.onPressed,
  });

  final String icon;
  final void Function() onPressed;

  @override
  Widget build(context) => IconButton(
        padding: EdgeInsets.all(0),
        icon: SVGIcon(
          icon,
          width: MEAS.appBarIconLength,
          height: MEAS.appBarIconLength,
        ),
        onPressed: onPressed,
      );
}
