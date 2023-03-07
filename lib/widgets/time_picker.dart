import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_bar.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/text_button.dart';
import 'package:doit/constants/styles.dart';

// ignore: must_be_immutable
class TimePicker extends StatelessWidget {
  TimePicker(
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
        children: <Widget>[
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
                onPressed: () => {
                  onConfirmed(_time),
                  Navigator.of(context).pop(),
                },
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 192.h,
            child: CupertinoDatePicker(
              initialDateTime: time,
              mode: mode,
              dateOrder: DatePickerDateOrder.ymd,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newTime) => _time = newTime,
            ),
          ),
        ],
      );
}
