import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/text_button.dart';
import 'package:doit/widgets/bottom_drawer_item.dart';
import 'package:doit/widgets/calendar.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/time_picker_drawer.dart';
import 'package:doit/widgets/time_picker.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingItemCalendar extends StatefulWidget {
  const BookkeepingItemCalendar({
    super.key,
    this.time,
    required this.onConfirmed,
  });
  final DateTime? time;
  final void Function(
    DateTime time,
  ) onConfirmed;

  @override
  _BookkeepingItemCalendarState createState() =>
      _BookkeepingItemCalendarState();
}

class _BookkeepingItemCalendarState extends State<BookkeepingItemCalendar> {
  late DateTime _time;

  @override
  void initState() {
    super.initState();
    _time = widget.time ?? nowTime;
  }

  @override
  Widget build(context) => Wrap(
        children: [
          AppBarBuilder(
            height: MEAS.dialogAppBarHeight,
            title: Text(
              '选择时间',
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
                  widget.onConfirmed(_time),
                  Navigator.pop(context),
                },
              ),
            ],
          ),
          Calendar(
            startTime: _time,
            endTime: _time,
            onDaySelected: (day, _) => setState(
              () => setState(
                () => _time = DateTime(
                  day.year,
                  day.month,
                  day.day,
                  _time.hour,
                  _time.minute,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 12,
              left: 16,
              right: 16,
              bottom: 18,
            ),
            child: Column(
              children: [
                BottomDrawerItem(
                  title: '时间',
                  value: getClockTime(_time),
                  icon: SVGIcon(
                    Ico.Time,
                    width: MEAS.itemOperationIconLength,
                    height: MEAS.itemOperationIconLength,
                  ),
                  onPressed: () => {
                    showBottomDrawer(
                      context: context,
                      builder: (context) => TimePickerDrawer(
                        _time,
                        mode: CupertinoDatePickerMode.time,
                        onConfirmed: (time) => setState(() => _time = time),
                      ),
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      );
}
