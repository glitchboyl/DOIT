import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/constants/styles.dart';

class SchedulePageAppBar extends AppBarBuilder {
  const SchedulePageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        leading: Builder(builder: (BuildContext context) {
          return SVGIconButton(
            'assets/images/menu.svg',
            onPressed: () => {Scaffold.of(context).openDrawer()},
          );
        }),
        title: TextBuilder(
          'DO IT',
          color: Styles.PrimaryTextColor,
          fontSize: Styles.largeTextSize,
          lineHeight: Styles.largeTextLineHeight,
          fontWeight: FontWeight.bold,
        ),
        trailings: [
          SVGIconButton(
            'assets/images/quadrant.svg',
            onPressed: () => {},
          )
        ],
      );
}
