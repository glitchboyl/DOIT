import 'package:flutter/cupertino.dart';
import 'package:doit/widgets/svg.dart';
import 'package:doit/constants/colors.dart';
import 'package:doit/constants/meas.dart';

CupertinoNavigationBar navigationBar({
  Widget? leading,
  Widget? middle,
  Widget? trailing,
}) =>
    CupertinoNavigationBar(
      backgroundColor: Colors.NavigatorBarColor,
      leading: leading,
      middle: middle,
      trailing: trailing,
      border: Border(
        bottom: BorderSide(color: Colors.NavigatorBarColor),
      ),
    );

Widget navigationBarButton(String icon, Function() onPressed) => Container(
      width: MEAS.navigationBarIconWidth,
      height: MEAS.navigationBarIconHeight,
      child: CupertinoButton(
        // color: CupertinoColors.activeBlue,
        padding: EdgeInsets.zero,
        pressedOpacity: 1,
        child: svg(
          icon,
        ),
        onPressed: onPressed,
      ),
    );
