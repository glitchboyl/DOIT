import 'package:flutter/widgets.dart';
import 'app_bar.dart';
import 'text.dart';
import 'text_button.dart';
import 'time_picker.dart';
import 'package:doit/constants/styles.dart';

// ignore: must_be_immutable
class TimePickerDrawer extends StatelessWidget {
  TimePickerDrawer(
    this.time, {
    super.key,
    required this.onConfirmed,
    this.mode = CupertinoDatePickerMode.date,
  });
  final DateTime time;
  final void Function(DateTime time) onConfirmed;
  final CupertinoDatePickerMode mode;

  late DateTime _time = time;

  @override
  Widget build(context) => Wrap(
        children: [
          AppBarBuilder(
            title: TextBuilder(
              '选择时间',
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
              mode: mode,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newTime) => _time = newTime,
            ),
          ),
        ],
      );
}
