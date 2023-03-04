import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'text.dart';
import 'package:doit/constants/styles.dart';

class ToDoItemCalendarSwitchButton extends StatelessWidget {
  const ToDoItemCalendarSwitchButton(
    this.text, {
    super.key,
    required this.onPressed,
    this.isActived = false,
  });

  final String text;
  final void Function() onPressed;
  final bool isActived;

  @override
  Widget build(BuildContext context) => TextButton(
        child: TextBuilder(
          text,
          color: isActived ? Styles.PrimaryColor : Styles.PrimaryTextColor,
          fontSize: Styles.calendarSwitchButtonTextSize,
          lineHeight: Styles.calendarSwitchButtonTextLineHeight,
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 2.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(8.r)),
          ),
          backgroundColor:
              isActived ? Styles.BackgroundColor : Styles.RegularBaseColor,
          foregroundColor:
              isActived ? Styles.BackgroundColor : Styles.RegularBaseColor,
          splashFactory: NoSplash.splashFactory,
        ),
        onPressed: () => {
          if (!isActived) onPressed(),
        },
      );
}
