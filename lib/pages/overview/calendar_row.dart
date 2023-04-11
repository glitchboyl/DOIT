import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/providers/to_do_list.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/icons.dart';
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
  int _focusedIndex = 0;

  @override
  void initState() {
    super.initState();
    _calendarItems = calendarMap.entries.toList();
    getFocusedIndex();
    _pageController = PageController(
      viewportFraction: 1 / 7,
      initialPage: _focusedIndex,
    );
  }

  void getFocusedIndex() => _focusedIndex = _calendarItems.indexWhere(
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

  void updateFocusedIndex() {
    getFocusedIndex();
    toCalendarItem(_focusedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: MEAS.calendarRowHeight,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      color: colorScheme.regularBaseColor,
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
                    color: colorScheme.primaryColor,
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
                  Ico.Triangle,
                  width: MEAS.arrowLength,
                  height: MEAS.arrowLength,
                  color: colorScheme.primaryColor,
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
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weekDayTextMap[date.weekday]!,
                            style: TextStyles.smallTextStyle.copyWith(
                              color: colorScheme.secondaryTextColor,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            date.day.toString(),
                            style: TextStyles.dateTextStyle.copyWith(
                              color: i == _focusedIndex
                                  ? colorScheme.regularBaseColor
                                  : colorScheme.primaryTextColor,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            highlight
                                ? (festival != '' ? festival : solarTerm)
                                : lunar.day,
                            style: TextStyles.tinyTextStyle.copyWith(
                              color: i == _focusedIndex
                                  ? colorScheme.regularBaseColor
                                  : highlight
                                      ? colorScheme.primaryColor
                                      : colorScheme.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: _calendarItems.length,
              onPageChanged: (index) {
                Provider.of<ToDoListProvider>(context, listen: false).focusDate(
                  _calendarItems[index].key,
                );
                setState(() => _focusedIndex = index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
