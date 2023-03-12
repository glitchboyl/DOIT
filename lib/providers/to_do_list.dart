import 'dart:async';
import 'package:flutter/widgets.dart';
import 'db.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/models/schedule.dart';
import 'package:doit/models/overview.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/utils/notification_service.dart';
import 'package:doit/constants/keys.dart';

class ToDoListProvider extends ChangeNotifier {
  final List<ToDoItem> _toDoList = [];
  final Map<ScheduleToDoListType, ScheduleToDoList> _scheduleToDoListMap = {
    ScheduleToDoListType.TodayUncompleted: ScheduleToDoList(
      title: '今天',
      list: [],
    ),
    ScheduleToDoListType.PastUncompleted: ScheduleToDoList(
      title: '过去',
      list: [],
    ),
    ScheduleToDoListType.TodayCompleted: ScheduleToDoList(
      title: '今天已完成',
      list: [],
    ),
  };
  final Map<DateTime, List<ToDoItem>> _overviewMap = {};
  OverviewMode _overviewMode = OverviewMode.Day;
  DateTime _focusedDate = nowTime.getDayTime();
  int _pageIndex = 0;
  ToDoItem? _fresh;

  List<ToDoItem> get toDoList => _toDoList;
  Map<ScheduleToDoListType, ScheduleToDoList> get scheduleToDoListMap =>
      _scheduleToDoListMap;
  Map<DateTime, List<ToDoItem>> get overviewMap => _overviewMap;
  DateTime get focusedDate => _focusedDate;
  OverviewMode get overviewMode => _overviewMode;
  int get pageIndex => _pageIndex;
  ToDoItem? get fresh => _fresh;

  Future<void> get() async {
    final maps = await DBHelper.get('to_do_list');
    _toDoList.addAll(
      List.generate(
        maps.length,
        (i) {
          final item = maps[i];
          final toDoItem = ToDoItem(
            id: item['id'],
            title: item['title'],
            remarks: item['remarks'],
            type: ToDoItemType.values[item['type']],
            level: ToDoItemLevel.values[item['level']],
            startTime: DateTime.fromMillisecondsSinceEpoch(item['startTime']),
            endTime: DateTime.fromMillisecondsSinceEpoch(item['endTime']),
            repeatType: RepeatType.values[item['repeatType']],
            completeTime: item['completeTime'] != null
                ? DateTime.fromMillisecondsSinceEpoch(item['completeTime'])
                : null,
          );
          updateSchedule(toDoItem);
          updateOverviewMap(toDoItem);
          return toDoItem;
        },
      ),
    );
    _overviewMap.values.forEach(
      (tdl) => tdl.sort(sortByStartTime),
    );
    _scheduleToDoListMap.values.forEach((tdl) {
      tdl.list.sort(sortByStartTime);
      tdl.list.sort(sortByLevel);
    });
    notifyListeners();
  }

  void updateSchedule(ToDoItem item) {
    if (item.completeTime == null) {
      if (item.startTime.isSameDay(nowTime)) {
        _scheduleToDoListMap[ScheduleToDoListType.TodayUncompleted]!
            .list
            .add(item);
      } else if (item.startTime.isBefore(nowTime)) {
        _scheduleToDoListMap[ScheduleToDoListType.PastUncompleted]!
            .list
            .add(item);
      }
    } else if (item.completeTime!.isSameDay(nowTime)) {
      _scheduleToDoListMap[ScheduleToDoListType.TodayCompleted]!.list.add(item);
    }
  }

  void updateOverviewMap(ToDoItem item) {
    final startDay = item.startTime.getDayTime();
    final endDay = item.endTime.getDayTime();
    DateTime _day = startDay;
    while (_day.compareTo(endDay) < 1) {
      if (overviewMap[_day] == null) {
        overviewMap[_day] = [];
      }
      overviewMap[_day]!.add(item);
      overviewMap[_day]!.sort(sortByStartTime);
      _day = _day.add(const Duration(days: 1));
    }
  }

  void reduce(ToDoItem oldItem) {
    if (oldItem.completeTime == null) {
      _scheduleToDoListMap[oldItem.startTime.isSameDay(nowTime)
              ? ScheduleToDoListType.TodayUncompleted
              : ScheduleToDoListType.PastUncompleted]!
          .list
          .remove(oldItem);
    } else if (oldItem.completeTime != null &&
        oldItem.completeTime!.isSameDay(nowTime)) {
      _scheduleToDoListMap[ScheduleToDoListType.TodayCompleted]!
          .list
          .remove(oldItem);
    }
    final startDay = oldItem.startTime.getDayTime();
    final endDay = oldItem.endTime.getDayTime();
    DateTime _day = startDay;
    while (_day.compareTo(endDay) < 1) {
      _overviewMap[_day]!.remove(oldItem);
      _day = _day.add(const Duration(days: 1));
    }
  }

  void changeScheduleToDoItemStatus(ScheduleToDoListType type, int index) {
    final ToDoItem toDoItem = _scheduleToDoListMap[type]!.list.removeAt(index);
    notifyListeners();
    Future.delayed(
      const Duration(milliseconds: 1),
      () {
        if (toDoItem.completeTime == null) {
          toDoItem.completeTime = DateTime.now();
          final list =
              _scheduleToDoListMap[ScheduleToDoListType.TodayCompleted]!.list;
          list.add(toDoItem);
          list.sort(sortByStartTime);
          list.sort(sortByLevel);
        } else {
          toDoItem.completeTime = null;
          final list = (scheduleToDoListMap[
                  toDoItem.startTime.isSameDay(nowTime)
                      ? ScheduleToDoListType.TodayUncompleted
                      : ScheduleToDoListType.PastUncompleted])!
              .list;
          list.add(toDoItem);
          list.sort(sortByStartTime);
          list.sort(sortByLevel);
        }
        _fresh = toDoItem;
        update(toDoItem);
      },
    );
  }

  Future<void> insert(ToDoItem item) async {
    _fresh = item;
    if (item.startTime.isSameDay(nowTime)) {
      final list =
          _scheduleToDoListMap[ScheduleToDoListType.TodayUncompleted]!.list;
      list.add(item);
      list.sort(sortByStartTime);
      list.sort(sortByLevel);
    } else if (item.startTime.isBefore(nowTime)) {
      final list =
          _scheduleToDoListMap[ScheduleToDoListType.PastUncompleted]!.list;
      list.add(item);
      list.sort(sortByStartTime);
      list.sort(sortByLevel);
    }
    final startDay = item.startTime.getDayTime();
    updateOverviewMap(item);
    _toDoList.add(item);
    if (_pageIndex == 1 && !_focusedDate.isSameDay(startDay)) {
      _focusedDate = startDay;
      if (_overviewMode == OverviewMode.Day) {
        (Keys.calendarRow.currentState as dynamic).updateFocusedIndex();
      } else {
        (Keys.calendarView.currentState as dynamic).updateFocusedDay();
      }
    }
    await setNotification(item);
    await DBHelper.insert('to_do_list', item);
    notifyListeners();
  }

  Future<void> update(ToDoItem item) async {
    await notificationService.cancelNotifications(item.id);
    await setNotification(item);
    await DBHelper.update('to_do_list', item);
    notifyListeners();
  }

  Future<void> delete(ToDoItem item) async {
    reduce(item);
    _toDoList.remove(item);
    await notificationService.cancelNotifications(item.id);
    await DBHelper.delete('to_do_list', item.id);
    notifyListeners();
  }

  Future<void> setNotification(ToDoItem item) async =>
      await notificationService.scheduleNotifications(
        item.id,
        item.title,
        item.remarks,
        item.startTime,
      );

  void focusDate(DateTime date) => {
        _focusedDate = date,
        notifyListeners(),
      };

  void toggleOverviewMode() => {
        _overviewMode = (_overviewMode == OverviewMode.Day
            ? OverviewMode.Month
            : OverviewMode.Day),
        notifyListeners(),
      };

  void currentPage(int index) => _pageIndex = index;

  void refresh() => _fresh = null;
}
