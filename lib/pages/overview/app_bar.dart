import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widgets.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/time_picker.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class OverviewPageAppBar extends AppBarBuilder {
  const OverviewPageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        leading: SVGIconButton(
          'assets/images/view.svg',
          onPressed: () => {},
        ),
        title: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextBuilder(
                '10月',
                color: Styles.PrimaryTextColor,
                fontSize: Styles.largeTextSize,
                lineHeight: Styles.largeTextLineHeight,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 5.w),
              SVGIcon(
                'assets/images/arrow.svg',
                width: MEAS.arrowLength,
                height: MEAS.arrowLength,
              ),
            ],
          ),
          onTap: () => showBottomDrawer(
            context: context,
            builder: (context) =>
                TimePicker(DateTime.now(), onConfirmed: (time) => {}),
          ),
        ),
      );
}
