import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'app_bar.dart';
import 'text.dart';
import 'text_button.dart';
import 'svg_icon.dart';
import 'to_do_item_calendar_switch_button.dart';
import 'calendar_item.dart';
import 'bottom_drawer_item.dart';
import 'time_picker.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/utils/lunar.dart';
import 'package:doit/utils/solar_terms.dart';
import 'package:doit/utils/festivals.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/calendar.dart';

final daysOfWeekTextStyle = TextStyle(
  color: Styles.SecondaryTextColor,
  fontSize: Styles.smallTextSize,
  height: Styles.smallTextLineHeight / Styles.smallTextSize,
);

final calendarItemBuilder = ({
  required String text,
  String? subText,
  Color? color,
  Color? textColor,
  Color? subTextColor,
}) =>
    CalendarItem(
      text: TextBuilder(
        text,
        color: textColor,
        fontSize: Styles.dateTextSize,
        lineHeight: Styles.dateTextLineHeight,
        fontWeight: FontWeight.bold,
      ),
      subText: subText != null
          ? TextBuilder(
              subText,
              color: subTextColor,
              fontSize: Styles.dateSubTextSize,
              lineHeight: Styles.dateSubTextLineHeight,
            )
          : null,
      color: color,
    );
final firstDay = DateTime(nowTime.year - 10);
final lastDay = DateTime(nowTime.year + 50);

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
  late PageController _pageController;
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
        children: <Widget>[
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
                SizedBox(width: 12.w),
                ToDoItemCalendarSwitchButton(
                  '结束',
                  isActived: _toggle,
                  onPressed: () => setState(() {
                    _focusedDay = _endTime ?? nowTime;
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                firstDay.isBefore(_focusedDay)
                    ? GestureDetector(
                        child: SVGIcon(
                          'assets/images/triangle.svg',
                          width: MEAS.arrowLength,
                          height: MEAS.arrowLength,
                        ),
                        onTap: () => {
                          setState(
                            () => _focusedDay = DateTime(
                              _focusedDay.year,
                              _focusedDay.month - 1,
                            ),
                          ),
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          )
                        },
                      )
                    : SizedBox(
                        width: MEAS.arrowLength,
                        height: MEAS.arrowLength,
                      ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  alignment: Alignment.center,
                  child: TextBuilder(
                    '${_focusedDay.year}.${fillDateZero(_focusedDay.month)}',
                    color: Styles.PrimaryTextColor,
                    fontSize: Styles.textSize,
                    lineHeight: Styles.textLineHeight,
                  ),
                ),
                lastDay.isAfter(_focusedDay)
                    ? GestureDetector(
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: SVGIcon(
                            'assets/images/triangle.svg',
                            width: MEAS.arrowLength,
                            height: MEAS.arrowLength,
                          ),
                        ),
                        onTap: () => {
                          setState(
                            () => _focusedDay = DateTime(
                              _focusedDay.year,
                              _focusedDay.month + 1,
                            ),
                          ),
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          ),
                        },
                      )
                    : SizedBox(
                        width: MEAS.arrowLength,
                        height: MEAS.arrowLength,
                      ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 12.h,
            ),
            child: TableCalendar(
              firstDay: firstDay,
              lastDay: lastDay,
              rangeStartDay: _startTime,
              rangeEndDay: _endTime,
              focusedDay: _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekHeight: 24.h,
              rowHeight: 40.h,
              onCalendarCreated: (controller) => _pageController = controller,
              headerVisible: false,
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) =>
                    calendarTextMap[date.weekday]!,
                weekdayStyle: daysOfWeekTextStyle,
                weekendStyle: daysOfWeekTextStyle,
              ),
              onPageChanged: (focusedDay) => setState(
                () => _focusedDay = focusedDay,
              ),
              onDaySelected: (day, _) => setState(() {
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
              }),
              calendarBuilders: CalendarBuilders(
                rangeHighlightBuilder: (context, day, isWithinRange) =>
                    isWithinRange
                        ? Container(
                            margin: EdgeInsets.only(
                              top: 1.h,
                              bottom: 1.h,
                              left: day.isSameDay(_startTime) ||
                                      (day.isSameDay(_endTime) &&
                                          day.weekday == DateTime.monday)
                                  ? 6.w
                                  : 0,
                              right: day.isSameDay(_endTime) ||
                                      (day.isSameDay(_startTime) &&
                                          day.weekday == DateTime.sunday)
                                  ? 6.w
                                  : 0,
                            ),
                            decoration: BoxDecoration(
                              color: Styles.CalendarDateRangeColor,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(
                                    (day.isSameDay(_startTime) ||
                                            day.weekday == DateTime.monday)
                                        ? MEAS.calendarItemRadius
                                        : 0),
                                right: Radius.circular(
                                    day.isSameDay(_endTime) ||
                                            day.weekday == DateTime.sunday
                                        ? MEAS.calendarItemRadius
                                        : 0),
                              ),
                            ),
                          )
                        : null,
                prioritizedBuilder: (context, day, focusedDay) {
                  final LunarDate lunar = getLunar(day);
                  String festival = getDateFestivals(lunar);
                  String solarTerm = getDateSolarTerm(day);
                  bool highlight = festival != '' || solarTerm != '';

                  return calendarItemBuilder(
                    color:
                        (day.isSameDay(_startTime) || day.isSameDay(_endTime))
                            ? Styles.PrimaryColor
                            : null,
                    text: day.day.toString(),
                    textColor:
                        (day.isSameDay(_startTime) || day.isSameDay(_endTime))
                            ? Styles.RegularBaseColor
                            : day.isSameMonth(focusedDay)
                                ? Styles.PrimaryTextColor
                                : Styles.DeactivedDeepColor,
                    subText: highlight
                        ? (festival != '' ? festival : solarTerm)
                        : lunar.day,
                    subTextColor:
                        (day.isSameDay(_startTime) || day.isSameDay(_endTime))
                            ? Styles.RegularBaseColor
                            : day.isSameMonth(focusedDay)
                                ? highlight
                                    ? Styles.PrimaryColor
                                    : Styles.PrimaryTextColor
                                : Styles.DeactivedDeepColor,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 12.h,
              left: 16.w,
              right: 16.w,
              bottom: 18.h,
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
                      builder: (context) => TimePicker(
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
