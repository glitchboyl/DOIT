import 'package:flutter/material.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/widgets/svg_icon.dart';

class SVGIconButton extends StatelessWidget {
  const SVGIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final String icon;
  final void Function() onPressed;

  @override
  Widget build(context) => IconButton(
        padding: EdgeInsets.all(0),
        icon: SVGIcon(
          icon: icon,
          width: MEAS.appBarIconWidth,
          height: MEAS.appBarIconHeight,
        ),
        onPressed: onPressed,
      );
}
