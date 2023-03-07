import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class AppBarBuilder extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBuilder({
    super.key,
    this.leading,
    this.title,
    this.trailings,
    this.backgroundColor = Styles.RegularBaseColor,
  });

  final Widget? leading;
  final Widget? title;
  final List<Widget>? trailings;
  final Color? backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(MEAS.appBarHeight);

  List<Widget> buildTrailings() {
    final List<Widget> _trailings = [];
    if (trailings != null) {
      for (int i = 0; i < trailings!.length; i++) {
        _trailings.add(trailings![i]);
        _trailings.add(SizedBox(width: MEAS.appBarIconLength / 2));
      }
      _trailings.removeLast();
    } else
      _trailings.add(SizedBox.shrink());
    return _trailings;
  }

  @override
  Widget build(context) => AppBar(
        leading: leading,
        automaticallyImplyLeading: false,
        title: title,
        centerTitle: true,
        actions: buildTrailings(),
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: MEAS.appBarHeight,
      );
}
