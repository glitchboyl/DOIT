import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/providers/to_do_list.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/calendar.dart';

const _kDuration = const Duration(milliseconds: 300);

class CalendarRow extends StatefulWidget {
  const CalendarRow({super.key});
  @override
  _CalendarRowState createState() => _CalendarRowState();
}

class _CalendarRowState extends State<CalendarRow> {
  late final PageController _pageController;
  late final _calendarItems;
  int _focusedDay = 0;

  @override
  void initState() {
    super.initState();
    _calendarItems = calendarMap.entries.toList();
    getFocusedDay();
    _pageController = PageController(
      viewportFraction: 1 / 7,
      initialPage: _focusedDay,
    );
  }

  void getFocusedDay() => _focusedDay = _calendarItems.indexWhere(
        (date) => Provider.of<ToDoListProvider>(context, listen: false)
            .focusedDate
            .isSameDay(
              date.key,
            ),
      );

  void toCalendarItem(int i) => _pageController.animateToPage(
        i,
        duration: _kDuration,
        curve: Curves.ease,
      );

  void updateFocusedDay() {
    getFocusedDay();
    toCalendarItem(_focusedDay);
  }

  @override
  Widget build(BuildContext context) => Container(
        height: MEAS.calendarRowHeight,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        color: Styles.RegularBaseColor,
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -2,
                left: 0,
                child: Container(
                  width: constraints.maxWidth / 7,
                  padding: EdgeInsets.symmetric(
                    horizontal: 6,
                  ),
                  height: 42,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Styles.PrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -MEAS.arrowLength - 2,
                left: constraints.maxWidth / 14 - MEAS.arrowLength / 2,
                child: RotatedBox(
                  quarterTurns: -1,
                  child: SVGIcon(
                    'assets/images/triangle.svg',
                    width: MEAS.arrowLength,
                    height: MEAS.arrowLength,
                    color: Styles.PrimaryColor,
                  ),
                ),
              ),
              PageView.builder(
                padEnds: false,
                controller: _pageController,
                itemBuilder: (context, i) {
                  final date = _calendarItems[i].key;
                  final lunar = _calendarItems[i].value.lunar;
                  final festival = _calendarItems[i].value.festival;
                  final solarTerm = _calendarItems[i].value.solarTerm;
                  bool highlight = festival != '' || solarTerm != '';
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => toCalendarItem(i),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: Column(
                          children: [
                            TextBuilder(
                              weekDayTextMap[date.weekday]!,
                              color: Styles.daysOfWeekTextStyle.color,
                              fontSize: Styles.daysOfWeekTextStyle.fontSize,
                              lineHeight: Styles.daysOfWeekTextStyle.height,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextBuilder(
                              date.day.toString(),
                              color: i == _focusedDay
                                  ? Styles.RegularBaseColor
                                  : Styles.PrimaryTextColor,
                              fontSize: Styles.dateTextSize,
                              lineHeight: Styles.dateTextLineHeight,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            TextBuilder(
                              highlight
                                  ? (festival != '' ? festival : solarTerm)
                                  : lunar.day,
                              color: i == _focusedDay
                                  ? Styles.RegularBaseColor
                                  : highlight
                                      ? Styles.PrimaryColor
                                      : Styles.PrimaryTextColor,
                              fontSize: Styles.dateSubTextSize,
                              lineHeight: Styles.dateSubTextLineHeight,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _calendarItems.length,
                onPageChanged: (day) {
                  Provider.of<ToDoListProvider>(context, listen: false)
                      .focusDate(
                    _calendarItems[day].key,
                  );
                  setState(() => _focusedDay = day);
                },
              ),
            ],
          ),
        ),
      );
}
