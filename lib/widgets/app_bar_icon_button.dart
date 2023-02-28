import 'package:flutter/material.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/widgets/svg_icon.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String icon;
  final void Function() onPressed;

  @override
  Widget build(context) => IconButton(
        padding: EdgeInsets.all(0),
        icon: SizedBox(
          width: MEAS.appBarIconWidth,
          height: MEAS.appBarIconHeight,
          child: SVGIcon(
            icon: icon,
          ),
        ),
        onPressed: onPressed,
      );
}
