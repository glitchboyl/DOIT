import 'package:doit/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class AppBarBuilder extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBuilder({
    super.key,
    this.leading,
    this.leadingWidth,
    this.title,
    this.trailings,
    this.backgroundColor,
    this.height = MEAS.appBarHeight,
  });

  final Widget? leading;
  final double? leadingWidth;
  final Widget? title;
  final List<Widget>? trailings;
  final Color? backgroundColor;
  final double height;

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
        leadingWidth: leadingWidth,
        automaticallyImplyLeading: false,
        title: title,
        centerTitle: true,
        actions: buildTrailings(),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.regularBaseColor,
        shadowColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: height,
      );
}
