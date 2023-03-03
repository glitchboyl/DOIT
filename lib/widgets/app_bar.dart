import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class AppBarBuilder extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBuilder({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.backgroundColor = Styles.RegularBaseColor,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final Color? backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(MEAS.appBarHeight);

  @override
  Widget build(context) => AppBar(
        leading: leading,
        automaticallyImplyLeading: false,
        title: title,
        centerTitle: true,
        actions: [trailing ?? SizedBox.shrink()],
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: MEAS.appBarHeight,
      );
}
