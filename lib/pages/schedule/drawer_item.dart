import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          child: Row(
            children: [
              if (icon != null) ...[
                color != null
                    ? Container(
                        padding: EdgeInsets.all(1.w),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: _getDrawerItemIcon(icon!),
                      )
                    : _getDrawerItemIcon(icon!),
                SizedBox(width: 10.w),
              ],
              Text(
                title,
                style: TextStyle(
                  color: Styles.PrimaryTextColor,
                  fontSize: Styles.drawerItemTextSize,
                  height: Styles.drawerItemTextLineHeight /
                      Styles.drawerItemTextSize,
                ),
              )
            ],
          ),
        ),
      );

  static final SVGIcon Function(String) _getDrawerItemIcon =
      (String icon) => SVGIcon(
            icon: icon,
            width: MEAS.drawerItemIconWidth,
            height: MEAS.drawerItemIconHeight,
          );
}
