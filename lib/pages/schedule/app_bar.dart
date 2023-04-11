import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';

class SchedulePageAppBar extends AppBarBuilder {
  const SchedulePageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        leading: SVGIconButton(
          Theme.of(context).brightness == Brightness.dark
              ? Ico.MenuDark
              : Ico.Menu,
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: Text(
          'DO IT',
          style: TextStyles.greatTextStyle,
        ),
        // trailings: [
        //   SVGIconButton(
        //     Ico.Quadrant,
        //     onPressed: () => {},
        //   )
        // ],
      );
}
