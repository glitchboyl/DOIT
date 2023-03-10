import 'package:doit/widgets/calendar.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/calendar.dart';
import 'package:doit/constants/styles.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) => Container(
        child: TableCalendar(
          firstDay: firstDay,
          lastDay: lastDay,
          focusedDay: nowTime,
          // rangeStartDay: widget.startTime,
          // rangeEndDay: widget.endTime,
          startingDayOfWeek: StartingDayOfWeek.monday,
          daysOfWeekHeight: 24,
          rowHeight: 40,
          headerVisible: false,
          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) => weekDayTextMap[date.weekday]!,
            weekdayStyle: Styles.daysOfWeekTextStyle,
            weekendStyle: Styles.daysOfWeekTextStyle,
          ),
          // onCalendarCreated: (controller) => _pageController = controller,
          onPageChanged: (focusedDay) {
            // setState(
            //   () => _focusedDay = focusedDay,
            // );
            // if (widget.onPageChanged != null) widget.onPageChanged!(focusedDay);
          },
          // onDaySelected: widget.onDaySelected,
          // calendarBuilders: CalendarBuilders(
          //   rangeHighlightBuilder: (context, day, isWithinRange) =>
          //       isWithinRange
          //           ? Container(
          //               margin: EdgeInsets.only(
          //                 top: 1,
          //                 bottom: 1,
          //                 left: day.isSameDay(widget.startTime) ||
          //                         (day.isSameDay(widget.endTime) &&
          //                             day.weekday == DateTime.monday)
          //                     ? 6
          //                     : 0,
          //                 right: day.isSameDay(widget.endTime) ||
          //                         (day.isSameDay(widget.startTime) &&
          //                             day.weekday == DateTime.sunday)
          //                     ? 6
          //                     : 0,
          //               ),
          //               decoration: BoxDecoration(
          //                 color: Styles.CalendarDateRangeColor,
          //                 borderRadius: BorderRadius.horizontal(
          //                   left: Radius.circular(
          //                       (day.isSameDay(widget.startTime) ||
          //                               day.weekday == DateTime.monday)
          //                           ? MEAS.calendarItemRadius
          //                           : 0),
          //                   right: Radius.circular(
          //                       day.isSameDay(widget.endTime) ||
          //                               day.weekday == DateTime.sunday
          //                           ? MEAS.calendarItemRadius
          //                           : 0),
          //                 ),
          //               ),
          //             )
          //           : null,
          //   prioritizedBuilder: (context, day, focusedDay) {
          //     day = DateTime(day.year, day.month, day.day);
          //     final LunarDate lunar = calendarMap[day]!.lunar;
          //     final String festival = calendarMap[day]!.festival;
          //     final String solarTerm = calendarMap[day]!.solarTerm;
          //     bool highlight = festival != '' || solarTerm != '';

          //     return calendarItemBuilder(
          //       color: (day.isSameDay(widget.startTime) ||
          //               day.isSameDay(widget.endTime))
          //           ? Styles.PrimaryColor
          //           : null,
          //       text: day.day.toString(),
          //       textColor: (day.isSameDay(widget.startTime) ||
          //               day.isSameDay(widget.endTime))
          //           ? Styles.RegularBaseColor
          //           : day.isSameMonth(focusedDay)
          //               ? Styles.PrimaryTextColor
          //               : Styles.DeactivedDeepColor,
          //       subText: highlight
          //           ? (festival != '' ? festival : solarTerm)
          //           : lunar.day,
          //       subTextColor: (day.isSameDay(widget.startTime) ||
          //               day.isSameDay(widget.endTime))
          //           ? Styles.RegularBaseColor
          //           : day.isSameMonth(focusedDay)
          //               ? highlight
          //                   ? Styles.PrimaryColor
          //                   : Styles.PrimaryTextColor
          //               : Styles.DeactivedDeepColor,
          //     );
          //   },
          // ),
        ),
      );
}
