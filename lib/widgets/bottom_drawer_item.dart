import 'package:flutter/widgets.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/constants/icons.dart';
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
        height: 50,
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 10),
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
              SizedBox(width: 10),
              RotatedBox(
                quarterTurns: -1,
                child: SVGIcon(
                  Ico.Arrow,
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
