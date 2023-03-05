import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_bar.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/constants/styles.dart';

class TimePicker extends StatelessWidget {
  TimePicker(
    this.time, {
    super.key,
    required this.onConfirmed,
  });
  final DateTime time;
  final void Function(DateTime time) onConfirmed;

  late DateTime _time;

  @override
  Widget build(context) => Wrap(
        children: <Widget>[
          AppBarBuilder(
            title: TextBuilder(
              '选择时间',
              color: Styles.PrimaryTextColor,
              fontSize: Styles.largeTextSize,
              lineHeight: Styles.largeTextLineHeight,
              fontWeight: FontWeight.bold,
            ),
            trailing: TextButton(
              child: TextBuilder(
                '确定',
                color: Styles.PrimaryColor,
                fontSize: Styles.textSize,
                lineHeight: Styles.textLineHeight,
              ),
              onPressed: () => {
                onConfirmed(_time),
                Navigator.of(context).pop(),
              },
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            height: 192.h,
            child: CupertinoDatePicker(
              initialDateTime: time,
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newTime) => _time = newTime,
            ),
          ),
        ],
      );
}
