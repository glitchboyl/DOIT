import 'package:flutter/widgets.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/text.dart';
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
        title: TextBuilder(
          '10月',
          color: Styles.PrimaryTextColor,
          fontSize: Styles.largeTextSize,
          lineHeight: Styles.largeTextLineHeight,
          fontWeight: FontWeight.bold,
        ),
      );
}
