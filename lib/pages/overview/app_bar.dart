import 'package:flutter/widgets.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/constants/styles.dart';

class OverviewPageAppBar extends AppBarBuilder {
  const OverviewPageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        leading: SVGIconButton(
          icon: 'assets/images/view.svg',
          onPressed: () => {},
        ),
        title: Text(
          '10月',
          style: TextStyle(
            color: Styles.PrimaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: Styles.largeTextSize,
            height: Styles.largeTextLineHeight / Styles.largeTextSize,
          ),
        ),
      );
}
