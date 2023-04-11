import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'text_button.dart';
import 'time_picker.dart';
import 'package:doit/constants/calendar.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class TimePickerDrawer extends StatelessWidget {
  TimePickerDrawer(
    this.time, {
    super.key,
    this.title,
    required this.onConfirmed,
    this.mode = CupertinoDatePickerMode.date,
  });

  final DateTime time;
  final String? title;
  final void Function(DateTime time) onConfirmed;
  final CupertinoDatePickerMode mode;

  late DateTime _time = time;

  String getTitle() {
    if (title != null) {
      return title!;
    }
    switch (mode) {
      case CupertinoDatePickerMode.year:
        return '选择年份';
      case CupertinoDatePickerMode.ym:
        return '选择月份';
      case CupertinoDatePickerMode.week:
        return '选择周';
      case CupertinoDatePickerMode.date:
        return '选择日期';
      default:
        return '选择时间';
    }
  }

  @override
  Widget build(context) => Wrap(
        children: [
          AppBarBuilder(
            height: MEAS.dialogAppBarHeight,
            title: Text(
              getTitle(),
              style: TextStyles.largeTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailings: [
              TextButtonBuilder(
                '确定',
                style: TextStyles.regularTextStyle.copyWith(
                  color: Theme.of(context).colorScheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () => {
                  onConfirmed(_time),
                  Navigator.pop(context),
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            height: 192,
            child: CupertinoDatePickerBuilder(
              initialDateTime: time,
              minimumDate: firstDay,
              maximumDate: lastDay,
              mode: mode,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newTime) => _time = newTime,
            ),
          ),
        ],
      );
}
