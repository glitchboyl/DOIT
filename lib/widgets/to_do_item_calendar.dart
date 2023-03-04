import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lunar/lunar.dart';
import 'app_bar.dart';
import 'text.dart';
import 'svg_icon.dart';
import 'to_do_item_calendar_switch_button.dart';
import 'calendar_item.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/utils/lunar.dart';
import 'package:doit/utils/solar_terms.dart';
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
  const ToDoItemCalendar({super.key});
  @override
  _ToDoItemCalendarState createState() => _ToDoItemCalendarState();
}

class _ToDoItemCalendarState extends State<ToDoItemCalendar> {
  late PageController _pageController;
  final rangeStartDay = nowTime;
  final rangeEndDay = nowTime;
  bool toggle = false;
  late DateTime _focusedDay = rangeStartDay;

  @override
  Widget build(context) => Wrap(
        children: <Widget>[
          AppBarBuilder(
            title: Wrap(
              children: [
                ToDoItemCalendarSwitchButton(
                  '开始',
                  isActived: !toggle,
                  onPressed: () => setState(() {
                    _focusedDay = rangeStartDay;
                    toggle = !toggle;
                  }),
                ),
                SizedBox(width: 12.w),
                ToDoItemCalendarSwitchButton(
                  '结束',
                  isActived: toggle,
                  onPressed: () => setState(() {
                    _focusedDay = rangeEndDay;
                    toggle = !toggle;
                  }),
                ),
              ],
            ),
            trailing: TextButton(
              child: TextBuilder(
                '确定',
                color: Styles.PrimaryColor,
                fontSize: Styles.textSize,
                lineHeight: Styles.textLineHeight,
              ),
              onPressed: () => {},
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                firstDay.isBefore(_focusedDay)
                    ? GestureDetector(
                        child: SVGIcon(
                          icon: 'assets/images/triangle.svg',
                          width: MEAS.arrowWidth,
                          height: MEAS.arrowHeight,
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
                        width: MEAS.arrowWidth,
                        height: MEAS.arrowHeight,
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
                            icon: 'assets/images/triangle.svg',
                            width: MEAS.arrowWidth,
                            height: MEAS.arrowHeight,
                            // onPressed: () => {},
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
                        width: MEAS.arrowWidth,
                        height: MEAS.arrowHeight,
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
              rangeStartDay: rangeStartDay,
              rangeEndDay: rangeEndDay,
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
              calendarBuilders: CalendarBuilders(
                rangeHighlightBuilder: (context, day, isWithinRange) =>
                    isWithinRange
                        ? Container(
                            margin: EdgeInsets.only(
                              top: 1.h,
                              bottom: 1.h,
                              left: day.isSameDay(rangeStartDay) ||
                                      (day.isSameDay(rangeEndDay) &&
                                          day.weekday == DateTime.monday)
                                  ? 6.w
                                  : 0,
                              right: day.isSameDay(rangeEndDay) ||
                                      (day.isSameDay(rangeStartDay) &&
                                          day.weekday == DateTime.sunday)
                                  ? 6.w
                                  : 0,
                            ),
                            decoration: BoxDecoration(
                              color: Styles.CalendarDateRangeColor,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(
                                    (day.isSameDay(rangeStartDay) ||
                                            day.weekday == DateTime.monday)
                                        ? MEAS.calendarItemRadius
                                        : 0),
                                right: Radius.circular(
                                    day.isSameDay(rangeEndDay) ||
                                            day.weekday == DateTime.sunday
                                        ? MEAS.calendarItemRadius
                                        : 0),
                              ),
                            ),
                          )
                        : null,
                prioritizedBuilder: (context, day, focusedDay) {
                  final lunar = Lunar.fromDate(day);
                  List<String> festivals = lunar.getFestivals();
                  String solarTerm = getDateSolarTerm(day);
                  bool highlight = festivals.length > 0 || solarTerm != '';

                  return calendarItemBuilder(
                    color: (day.isSameDay(rangeStartDay) ||
                            day.isSameDay(rangeEndDay))
                        ? Styles.PrimaryColor
                        : null,
                    text: day.day.toString(),
                    textColor: (day.isSameDay(rangeStartDay) ||
                            day.isSameDay(rangeEndDay))
                        ? Styles.RegularBaseColor
                        : day.isSameMonth(focusedDay)
                            ? Styles.PrimaryTextColor
                            : Styles.DeactivedDeepColor,
                    subText: festivals.length > 0
                        ? festivals[0]
                        : solarTerm != ''
                            ? solarTerm
                            : getLunar(day).day,
                    subTextColor: (day.isSameDay(rangeStartDay) ||
                            day.isSameDay(rangeEndDay))
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
        ],
      );
}
