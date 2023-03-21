import 'package:flutter/widgets.dart';
import 'app_bar.dart';
import 'text.dart';
import 'text_button.dart';
import 'time_picker.dart';
import 'package:doit/constants/calendar.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class TimePickerDrawer extends StatelessWidget {
  TimePickerDrawer(
    this.time, {
    super.key,
    this.title = '选择时间',
    required this.onConfirmed,
    this.mode = CupertinoDatePickerMode.date,
  });

  final DateTime time;
  final String title;
  final void Function(DateTime time) onConfirmed;
  final CupertinoDatePickerMode mode;

  late DateTime _time = time;

  @override
  Widget build(context) => Wrap(
        children: [
          AppBarBuilder(
            height: MEAS.dialogAppBarHeight,
            title: TextBuilder(
              title,
              color: Styles.PrimaryTextColor,
              fontSize: Styles.largeTextSize,
              lineHeight: Styles.largeTextLineHeight,
              fontWeight: FontWeight.bold,
            ),
            trailings: [
              TextButtonBuilder(
                '确定',
                color: Styles.PrimaryColor,
                fontSize: Styles.textSize,
                lineHeight: Styles.textLineHeight,
                fontWeight: FontWeight.bold,
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
