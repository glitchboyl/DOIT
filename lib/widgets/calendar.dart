import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'svg_icon.dart';
import 'calendar_item.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/utils/lunar.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/calendar.dart';

final calendarItemBuilder = ({
  required String text,
  String? subText,
  Color? color,
  Color? textColor,
  Color? subTextColor,
}) =>
    CalendarItem(
      text: Text(
        text,
        style: TextStyles.dateTextStyle.copyWith(
          color: textColor,
        ),
      ),
      subText: subText != null
          ? Text(
              subText,
              style: TextStyles.tinyTextStyle.copyWith(
                color: subTextColor,
              ),
            )
          : null,
      color: color,
    );

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
  Widget build(context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              firstDay.isBefore(widget.focusedDay ?? _focusedDay)
                  ? GestureDetector(
                      child: SVGIcon(
                        isDarkMode ? Ico.TriangleDark : Ico.Triangle,
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
                child: Text(
                  '${_focusedDay.year}.${fillDateZero(_focusedDay.month)}',
                  style: TextStyles.regularTextStyle,
                ),
              ),
              lastDay.isAfter(_focusedDay)
                  ? GestureDetector(
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: SVGIcon(
                          isDarkMode ? Ico.TriangleDark : Ico.Triangle,
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
              dowTextFormatter: (date, locale) => weekDayTextMap[date.weekday]!,
              weekdayStyle: TextStyles.smallTextStyle.copyWith(
                color: colorScheme.secondaryTextColor,
              ),
              weekendStyle: TextStyles.smallTextStyle.copyWith(
                color: colorScheme.secondaryTextColor,
              ),
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
                            color: colorScheme.calendarDateRangeColor,
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
                day = DateTime(day.year, day.month, day.day);
                final LunarDate lunar = calendarMap[day]!.lunar;
                final String festival = calendarMap[day]!.festival;
                final String solarTerm = calendarMap[day]!.solarTerm;
                bool highlight = festival != '' || solarTerm != '';

                return calendarItemBuilder(
                  color: (day.isSameDay(widget.startTime) ||
                          day.isSameDay(widget.endTime))
                      ? colorScheme.primaryColor
                      : null,
                  text: day.day.toString(),
                  textColor: (day.isSameDay(widget.startTime) ||
                          day.isSameDay(widget.endTime))
                      ? colorScheme.regularBaseColor
                      : day.isSameMonth(focusedDay)
                          ? colorScheme.primaryTextColor
                          : colorScheme.deactivedDeepColor,
                  subText: highlight
                      ? (festival != '' ? festival : solarTerm)
                      : lunar.day,
                  subTextColor: (day.isSameDay(widget.startTime) ||
                          day.isSameDay(widget.endTime))
                      ? colorScheme.regularBaseColor
                      : day.isSameMonth(focusedDay)
                          ? highlight
                              ? colorScheme.primaryColor
                              : colorScheme.primaryTextColor
                          : colorScheme.deactivedDeepColor,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
