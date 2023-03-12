import 'package:flutter/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:doit/widgets/text.dart';
import 'calendar_view_to_do_item.dart';
import 'to_do_list_dialog.dart';
import 'package:doit/providers/to_do_list.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/utils/lunar.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/constants/calendar.dart';
import 'package:doit/constants/styles.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late DateTime _focusedDay;
  bool isDialogActived = false;

  @override
  void initState() {
    super.initState();
    _focusedDay =
        Provider.of<ToDoListProvider>(context, listen: false).focusedDate;
  }

  void updateFocusedDay() {
    setState(
      () => _focusedDay =
          Provider.of<ToDoListProvider>(context, listen: false).focusedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ToDoListProvider>(context, listen: false);
    return Container(
      color: Styles.RegularBaseColor,
      child: TableCalendar(
        firstDay: firstDay,
        lastDay: lastDay,
        focusedDay: _focusedDay,
        rangeStartDay: _provider.focusedDate,
        rangeEndDay: _provider.focusedDate,
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekHeight: 36,
        rowHeight: 99,
        headerVisible: false,
        shouldFillViewport: true,
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (date, locale) => weekDayTextMap[date.weekday]!,
          weekdayStyle: Styles.daysOfWeekTextStyle,
          weekendStyle: Styles.daysOfWeekTextStyle,
          decoration: BoxDecoration(
            color: Styles.RegularBaseColor,
          ),
        ),
        calendarStyle: CalendarStyle(
          markersAlignment: Alignment.topCenter,
        ),
        onPageChanged: (focusedDay) {
          _provider.focusDate(focusedDay);
          _focusedDay = focusedDay;
        },
        onDaySelected: (day, _) {
          if (!_provider.focusedDate.isSameDay(day)) {
            _provider.focusDate(day.getDayTime());
          }
          isDialogActived = true;
          showBottomDrawer(
            context: context,
            builder: (context) => ToDoListDialog(),
            backgroundColor: Styles.BackgroundColor,
            onDismissed: () => isDialogActived = false,
          );
        },
        calendarBuilders: CalendarBuilders(
          markerBuilder: (BuildContext context, date, events) {
            final toDoList = _provider.overviewMap[date.getDayTime()];
            if (toDoList == null || toDoList.length == 0) {
              return SizedBox.shrink();
            }
            final ItemScrollController _scrollController =
                ItemScrollController();
            final _positionsListener = ItemPositionsListener.create();
            if (date.isSameDay(_provider.focusedDate) &&
                _provider.fresh != null) {
              Future.delayed(
                const Duration(milliseconds: 1),
                () {
                  final _freshWidgetIndex =
                      toDoList.indexWhere((item) => item == _provider.fresh);
                  final _itemPositions =
                      _positionsListener.itemPositions.value.toList();
                  if (_freshWidgetIndex != -1 &&
                      (_itemPositions.first.index > _freshWidgetIndex ||
                          _itemPositions.last.index < _freshWidgetIndex)) {
                    _scrollController.jumpTo(
                      index: _freshWidgetIndex,
                    );
                  }
                  if (!isDialogActived) {
                    _provider.refresh();
                  }
                },
              );
            }
            return Container(
              margin: EdgeInsets.only(
                top: 40,
                left: 1,
                right: 1,
              ),
              child: ScrollablePositionedList.builder(
                itemScrollController: _scrollController,
                itemPositionsListener: _positionsListener,
                itemBuilder: (context, i) => CalendarViewToDoItem(toDoList[i]),
                itemCount: toDoList.length,
              ),
            );
          },
          prioritizedBuilder: (context, day, focusedDay) {
            day = DateTime(day.year, day.month, day.day);
            final LunarDate lunar = calendarMap[day]!.lunar;
            final String festival = calendarMap[day]!.festival;
            final String solarTerm = calendarMap[day]!.solarTerm;
            bool highlight = festival != '' || solarTerm != '';

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Styles.BackgroundColor,
                  width: 1,
                ),
              ),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  if (day.isSameDay(_provider.focusedDate))
                    Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: Styles.PrimaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  Column(
                    children: [
                      SizedBox(height: 4),
                      TextBuilder(
                        day.day.toString(),
                        color: day.isSameDay(_provider.focusedDate)
                            ? Styles.RegularBaseColor
                            : day.isSameMonth(focusedDay)
                                ? Styles.PrimaryTextColor
                                : Styles.DeactivedDeepColor,
                        fontSize: Styles.dateTextSize,
                        lineHeight: Styles.dateTextLineHeight,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 2),
                      TextBuilder(
                        highlight
                            ? (festival != '' ? festival : solarTerm)
                            : lunar.day,
                        color: day.isSameDay(_provider.focusedDate)
                            ? Styles.RegularBaseColor
                            : day.isSameMonth(focusedDay)
                                ? highlight
                                    ? Styles.PrimaryColor
                                    : Styles.PrimaryTextColor
                                : Styles.DeactivedDeepColor,
                        fontSize: Styles.tinyTextSize,
                        lineHeight: Styles.tinyTextLineHeight,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
