import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class SchedulePageDrawerItem extends StatelessWidget {
  const SchedulePageDrawerItem({
    Key? key,
    this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String? icon;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          child: Row(
            children: [
              if (icon != null) ...[
                SVGIcon(
                  icon: icon!,
                  width: MEAS.drawerItemIconWidth,
                  height: MEAS.drawerItemIconHeight,
                ),
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
}
