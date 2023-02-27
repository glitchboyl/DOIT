import 'package:flutter/material.dart';
import 'package:doit/widgets/svg.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

AppBar appBar({
  Widget? leading,
  Widget? title,
  Widget? trailing,
}) =>
    AppBar(
      leading: leading,
      centerTitle: true,
      title: title,
      actions: trailing != null ? [trailing] : [],
      // actions: [Container(width: double.infinity, height: double.infinity, child: leading)],
      // actions: [Container(color: Colors.red,child: leading!,)],
      // actions: [RotatedBox(quarterTurns: 2, child: leading!)],
      backgroundColor: Styles.AppBarColor,
      shadowColor: Colors.transparent,
    );

Widget appBarIconButton(String icon, Function() onPressed) => IconButton(
      icon: SizedBox(
        width: MEAS.navigationBarIconWidth,
        height: MEAS.navigationBarIconHeight,
        child: svg(
          icon,
        ),
      ),
      onPressed: onPressed,
    );
