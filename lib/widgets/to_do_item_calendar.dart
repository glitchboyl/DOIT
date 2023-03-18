import 'package:flutter/widgets.dart';
import 'app_bar.dart';
import 'bottom_drawer_select.dart';
import 'text_button.dart';
import 'svg_icon.dart';
import 'switch_button.dart';
import 'calendar.dart';
import 'bottom_drawer_item.dart';
import 'time_picker_drawer.dart';
import 'time_picker.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class ToDoItemCalendar extends StatefulWidget {
  const ToDoItemCalendar({
    super.key,
    this.startTime,
    this.endTime,
    this.notificationType = NotificationType.None,
    required this.onConfirmed,
  });
  final DateTime? startTime;
  final DateTime? endTime;
  final NotificationType notificationType;
  final void Function(
    DateTime startTime,
    DateTime? endTime,
    NotificationType notificationType,
  ) onConfirmed;

  @override
  _ToDoItemCalendarState createState() => _ToDoItemCalendarState();
}

class _ToDoItemCalendarState extends State<ToDoItemCalendar> {
  late DateTime _startTime;
  late DateTime? _endTime;
  late DateTime _focusedDay;
  late NotificationType _notificationType;
  bool _toggle = false;

  @override
  void initState() {
    super.initState();
    _startTime = widget.startTime ?? DateTime.now();
    _endTime = widget.endTime;
    _focusedDay = _startTime;
    _notificationType = widget.notificationType;
  }

  @override
  Widget build(context) => Wrap(
        children: [
          AppBarBuilder(
            height: MEAS.dialogAppBarHeight,
            title: Wrap(
              children: [
                SwitchButton(
                  '开始',
                  isActived: !_toggle,
                  onPressed: () => setState(() {
                    _focusedDay = _startTime;
                    _toggle = !_toggle;
                  }),
                ),
                SizedBox(width: 12),
                SwitchButton(
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
                    _notificationType,
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
                  onPressed: () => showBottomDrawer(
                    context: context,
                    builder: (context) => TimePickerDrawer(
                      _toggle
                          ? (_endTime != null ? _endTime! : _startTime)
                          : _startTime,
                      mode: CupertinoDatePickerMode.time,
                      onConfirmed: (time) => setState(
                        () {
                          if (_toggle)
                            _endTime = time;
                          else
                            _startTime = time;
                        },
                      ),
                    ),
                  ),
                ),
                BottomDrawerItem(
                  title: '提醒',
                  value: notificationTypeMap[_notificationType]![0],
                  icon: SVGIcon(
                    'assets/images/notification.svg',
                    width: MEAS.itemOperationIconLength,
                    height: MEAS.itemOperationIconLength,
                  ),
                  onPressed: () => showBottomDrawer(
                    context: context,
                    builder: (context) => BottomDrawerSelect<NotificationType>(
                      title: '提醒',
                      selectList: NotificationType.values,
                      itemBuilder: (type, index) => BottomDrawerItem(
                        key: ValueKey(type),
                        title: notificationTypeMap[type]![0],
                        icon: SVGIcon(
                          'assets/images/radio${type == _notificationType ? '_checked' : ''}.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      onSelected: (type, index) => {
                        if (_notificationType != type)
                          setState(() {
                            _notificationType = type;
                          })
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
