import 'package:flutter/widgets.dart';
import 'app_bar.dart';
import 'text_button.dart';
import 'svg_icon.dart';
import 'to_do_item_calendar_switch_button.dart';
import 'calendar.dart';
import 'bottom_drawer_item.dart';
import 'time_picker_drawer.dart';
import 'time_picker.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class ToDoItemCalendar extends StatefulWidget {
  const ToDoItemCalendar({
    super.key,
    this.startTime,
    this.endTime,
    required this.onConfirmed,
  });
  final DateTime? startTime;
  final DateTime? endTime;
  final void Function(
    DateTime startTime,
    DateTime? endTime,
  ) onConfirmed;

  @override
  _ToDoItemCalendarState createState() => _ToDoItemCalendarState();
}

class _ToDoItemCalendarState extends State<ToDoItemCalendar> {
  late DateTime _startTime;
  late DateTime? _endTime;
  late DateTime _focusedDay;
  bool _toggle = false;

  @override
  void initState() {
    super.initState();
    _startTime = widget.startTime ?? nowTime;
    _endTime = widget.endTime;
    _focusedDay = _startTime;
  }

  @override
  Widget build(context) => Wrap(
        children: [
          AppBarBuilder(
            title: Wrap(
              children: [
                ToDoItemCalendarSwitchButton(
                  '开始',
                  isActived: !_toggle,
                  onPressed: () => setState(() {
                    _focusedDay = _startTime;
                    _toggle = !_toggle;
                  }),
                ),
                SizedBox(width: 12),
                ToDoItemCalendarSwitchButton(
                  '结束',
                  isActived: _toggle,
                  onPressed: () => setState(() {
                    _focusedDay = _endTime ?? _startTime;
                    _toggle = !_toggle;
                  }),
                ),
              ],
            ),
            trailings: [
              TextButtonBuilder(
                '确定',
                color: Styles.PrimaryColor,
                fontSize: Styles.textSize,
                lineHeight: Styles.textLineHeight,
                fontWeight: FontWeight.bold,
                onPressed: () => {
                  widget.onConfirmed(
                    _startTime,
                    _endTime,
                  ),
                  Navigator.pop(context),
                },
              ),
            ],
          ),
          Calendar(
            startTime: _startTime,
            endTime: _endTime,
            focusedDay: _focusedDay,
            onPageChanged: (focusedDay) => setState(
              () => _focusedDay = focusedDay,
            ),
            onDaySelected: (day, _) => setState(
              () {
                if (_toggle) {
                  _endTime = DateTime(
                    day.year,
                    day.month,
                    day.day,
                    _endTime != null ? _endTime!.hour : _startTime.hour,
                    _endTime != null ? _endTime!.minute : _startTime.minute,
                  );
                  if (_endTime!.isBefore(_startTime)) _startTime = _endTime!;
                } else {
                  _startTime = DateTime(
                    day.year,
                    day.month,
                    day.day,
                    _startTime.hour,
                    _startTime.minute,
                  );
                  if (_endTime != null && _startTime.isAfter(_endTime!))
                    _endTime = null;
                }
              },
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
                  value: getClockTime(_toggle
                      ? (_endTime != null ? _endTime! : _startTime)
                      : _startTime),
                  icon: SVGIcon(
                    'assets/images/time.svg',
                    width: MEAS.itemOperationIconLength,
                    height: MEAS.itemOperationIconLength,
                  ),
                  onPressed: () => {
                    showBottomDrawer(
                      context: context,
                      builder: (context) => TimePickerDrawer(
                        _toggle
                            ? (_endTime != null ? _endTime! : _startTime)
                            : _startTime,
                        mode: CupertinoDatePickerMode.time,
                        onConfirmed: (time) => setState(() {
                          if (_toggle)
                            _endTime = time;
                          else
                            _startTime = time;
                        }),
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
