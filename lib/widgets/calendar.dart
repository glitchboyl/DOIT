import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'svg_icon.dart';
import 'text.dart';
import 'calendar_item.dart';
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

class Calendar extends StatefulWidget {
  Calendar({
    super.key,
    this.focusedDay,
    this.startTime,
    this.endTime,
    this.onPageChanged,
    this.onDaySelected,
  });
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? focusedDay;
  final void Function(DateTime)? onPageChanged;
  final void Function(DateTime, DateTime)? onDaySelected;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final PageController _pageController;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay ?? widget.startTime ?? DateTime.now();
  }

  @override
  Widget build(context) => Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                firstDay.isBefore(widget.focusedDay ?? _focusedDay)
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
                  margin: EdgeInsets.symmetric(horizontal: 10),
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
              horizontal: 10,
              vertical: 12,
            ),
            child: TableCalendar(
              firstDay: firstDay,
              lastDay: lastDay,
              rangeStartDay: widget.startTime,
              rangeEndDay: widget.endTime,
              focusedDay: widget.focusedDay ?? _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekHeight: 24,
              rowHeight: 40,
              headerVisible: false,
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) =>
                    calendarTextMap[date.weekday]!,
                weekdayStyle: daysOfWeekTextStyle,
                weekendStyle: daysOfWeekTextStyle,
              ),
              onCalendarCreated: (controller) => _pageController = controller,
              onPageChanged: (focusedDay) {
                setState(
                  () => _focusedDay = focusedDay,
                );
                if (widget.onPageChanged != null)
                  widget.onPageChanged!(focusedDay);
              },
              onDaySelected: widget.onDaySelected,
              calendarBuilders: CalendarBuilders(
                rangeHighlightBuilder: (context, day, isWithinRange) =>
                    isWithinRange
                        ? Container(
                            margin: EdgeInsets.only(
                              top: 1,
                              bottom: 1,
                              left: day.isSameDay(widget.startTime) ||
                                      (day.isSameDay(widget.endTime) &&
                                          day.weekday == DateTime.monday)
                                  ? 6
                                  : 0,
                              right: day.isSameDay(widget.endTime) ||
                                      (day.isSameDay(widget.startTime) &&
                                          day.weekday == DateTime.sunday)
                                  ? 6
                                  : 0,
                            ),
                            decoration: BoxDecoration(
                              color: Styles.CalendarDateRangeColor,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(
                                    (day.isSameDay(widget.startTime) ||
                                            day.weekday == DateTime.monday)
                                        ? MEAS.calendarItemRadius
                                        : 0),
                                right: Radius.circular(
                                    day.isSameDay(widget.endTime) ||
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
                    color: (day.isSameDay(widget.startTime) ||
                            day.isSameDay(widget.endTime))
                        ? Styles.PrimaryColor
                        : null,
                    text: day.day.toString(),
                    textColor: (day.isSameDay(widget.startTime) ||
                            day.isSameDay(widget.endTime))
                        ? Styles.RegularBaseColor
                        : day.isSameMonth(focusedDay)
                            ? Styles.PrimaryTextColor
                            : Styles.DeactivedDeepColor,
                    subText: highlight
                        ? (festival != '' ? festival : solarTerm)
                        : lunar.day,
                    subTextColor: (day.isSameDay(widget.startTime) ||
                            day.isSameDay(widget.endTime))
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
