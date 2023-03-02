import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/constants/styles.dart';

class SchedulePageAppBar extends AppBarBuilder {
  const SchedulePageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        leading: Builder(builder: (BuildContext context) {
          return SVGIconButton(
            icon: 'assets/images/menu.svg',
            onPressed: () => {Scaffold.of(context).openDrawer()},
          );
        }),
        title: Text(
          'DO IT',
          style: TextStyle(
            color: Styles.PrimaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: Styles.largeTextSize,
            height: Styles.largeTextLineHeight / Styles.largeTextSize,
          ),
        ),
        trailing: SVGIconButton(
          icon: 'assets/images/quadrant.svg',
          onPressed: () => {},
        ),
      );
}
