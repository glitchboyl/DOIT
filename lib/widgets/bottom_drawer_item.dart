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

  Widget buildWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = TextStyles.regularTextStyle.copyWith(
      color: colorScheme.primaryTextColor,
    );
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          if (icon != null) ...[
            icon!,
            SizedBox(width: 10),
          ],
          Text(
            title,
            style: textStyle,
          ),
          Spacer(),
          if (value != null)
            Text(
              value!,
              style: textStyle,
            ),
          if (onPressed != null && !hideArrow) ...[
            SizedBox(width: 10),
            RotatedBox(
              quarterTurns: -1,
              child: SVGIcon(
                Ico.Arrow,
                width: MEAS.indicatorLength,
                height: MEAS.indicatorLength,
                color: colorScheme.primaryTextColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => onPressed != null
      ? GestureDetector(
          child: buildWidget(context),
          behavior: HitTestBehavior.translucent,
          onTap: onPressed,
        )
      : buildWidget(context);
}
