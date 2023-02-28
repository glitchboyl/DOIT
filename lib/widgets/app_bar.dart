import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class AppBarBuilder extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBuilder({
    Key? key,
    this.leading,
    this.title,
    this.trailing,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final Widget? trailing;

  @override
  Size get preferredSize => Size.fromHeight(MEAS.appBarHeight);

  @override
  Widget build(context) => AppBar(
        leading: leading,
        automaticallyImplyLeading: false,
        title: title,
        centerTitle: true,
        actions: [trailing ?? SizedBox.shrink()],
        backgroundColor: Styles.AppBarColor,
        shadowColor: Colors.transparent,
        toolbarHeight: MEAS.appBarHeight,
      );
}
