import 'package:flutter/material.dart';
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

  Widget buildWidget(BuildContext context) => SizedBox(
        height: 50,
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 10),
            ],
            Text(
              title,
              style: TextStyles.regularTextStyle,
            ),
            Spacer(),
            if (value != null)
              Text(
                value!,
                style: TextStyles.regularTextStyle,
              ),
            if (onPressed != null && !hideArrow) ...[
              SizedBox(width: 10),
              RotatedBox(
                quarterTurns: -1,
                child: SVGIcon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Ico.ArrowDark
                      : Ico.Arrow,
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
          child: buildWidget(context),
          behavior: HitTestBehavior.translucent,
          onTap: onPressed,
        )
      : buildWidget(context);
}
