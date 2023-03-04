import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/constants/styles.dart';

class ScheduleToDoListTitle extends StatelessWidget {
  const ScheduleToDoListTitle(
    this.title, {
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(
          top: 12.h,
        ),
        child: TextBuilder(
          title,
          color: Styles.PrimaryTextColor,
          fontSize: Styles.smallTextSize,
          lineHeight: Styles.smallTextLineHeight,
          fontWeight: FontWeight.bold,
        ),
      );
}
