import 'package:flutter/material.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class SchedulePageDrawerItem extends StatelessWidget {
  const SchedulePageDrawerItem({
    super.key,
    this.icon,
    this.color,
    required this.title,
    this.onTap,
  });
  final String? icon;
  final Color? color;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            if (icon != null) ...[
              color != null
                  ? Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: _getDrawerItemIcon(icon!),
                    )
                  : _getDrawerItemIcon(icon!),
              SizedBox(width: 10),
            ],
            Text(
              title,
              style: TextStyles.largeTextStyle.copyWith(
                color: colorScheme.primaryTextColor,
              ),
            ),
            if (onTap == null) ...[
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '施工中',
                  style: TextStyles.smallTextStyle.copyWith(
                    color: colorScheme.primaryTextColor,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  static final SVGIcon Function(String) _getDrawerItemIcon =
      (String icon) => SVGIcon(
            icon,
            width: MEAS.drawerItemIconLength,
            height: MEAS.drawerItemIconLength,
          );
}
