import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:doit/widgets/interactive_button.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/constants/meas.dart';

class SimpleToDoItemOperation extends StatelessWidget {
  const SimpleToDoItemOperation({
    Key? key,
    required this.icon,
    required this.color,
    this.activedColor,
    required this.onPressed,
  }) : super(key: key);

  final String icon;
  final Color color;
  final Color? activedColor;
  final void Function() onPressed;

  @override
  Widget build(context) => Expanded(
        child: Container(
          height: double.infinity,
          child: InteractiveButton(
            color: color,
            activedColor: activedColor,
            child: SVGIcon(
              icon: icon,
              width: MEAS.simpleToDoItemOperationIconWidth,
              height: MEAS.simpleToDoItemOperationIconHeight,
            ),
            onPressed: () => {
              Slidable.of(context)?.close(),
              onPressed(),
            },
          ),
        ),
      );
}
