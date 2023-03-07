import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BottomDrawerItem extends StatelessWidget {
  const BottomDrawerItem({
    super.key,
    this.icon,
    required this.title,
    this.value,
    this.hideArrow = false,
    this.onPressed,
  });

  final Widget? icon;
  final String title;
  final String? value;
  final bool hideArrow;
  final void Function()? onPressed;

  Widget buildWidget() => SizedBox(
        height: 50.h,
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 10.w),
            ],
            TextBuilder(
              title,
              color: Styles.PrimaryTextColor,
              fontSize: Styles.textSize,
              lineHeight: Styles.textLineHeight,
            ),
            Spacer(),
            if (value != null)
              TextBuilder(
                value!,
                color: Styles.PrimaryTextColor,
                fontSize: Styles.textSize,
                lineHeight: Styles.textLineHeight,
              ),
            if (onPressed != null && !hideArrow) ...[
              SizedBox(width: 10.w),
              RotatedBox(
                quarterTurns: -1,
                child: SVGIcon(
                  'assets/images/arrow.svg',
                  width: MEAS.arrowLength,
                  height: MEAS.arrowLength,
                ),
              ),
            ],
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => onPressed != null
      ? GestureDetector(
          child: buildWidget(),
          behavior: HitTestBehavior.translucent,
          onTap: onPressed,
        )
      : buildWidget();
}
