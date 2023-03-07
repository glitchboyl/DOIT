import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'text_button.dart';
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
  Widget build(BuildContext context) => TextButtonBuilder(
        text,
        color: isActived ? Styles.PrimaryColor : Styles.PrimaryTextColor,
        fontSize: Styles.calendarSwitchButtonTextSize,
        lineHeight: Styles.calendarSwitchButtonTextLineHeight,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 2.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(8.r)),
        ),
        backgroundColor:
            isActived ? Styles.BackgroundColor : Styles.RegularBaseColor,
        onPressed: () => {
          if (!isActived) onPressed(),
        },
      );
}
