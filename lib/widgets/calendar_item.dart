import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/constants/meas.dart';

class CalendarItem extends StatelessWidget {
  CalendarItem({
    super.key,
    required this.text,
    this.subText,
    this.color,
  });

  final Widget text;
  final Widget? subText;
  final Color? color;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MEAS.calendarItemRadius),
          color: color,
        ),
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            text,
            if (subText != null) ...[
              SizedBox(height: 2.h),
              subText!,
            ],
          ],
        ),
      );
}
