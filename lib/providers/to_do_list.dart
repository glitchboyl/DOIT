import 'dart:async';
import 'package:doit/utils/time.dart';
import 'package:flutter/widgets.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/models/schedule.dart';
import 'db.dart';

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

  List<ToDoItem> get toDoList => _toDoList;
  Map<ScheduleToDoListType, ScheduleToDoList> get scheduleToDoListMap =>
      _scheduleToDoListMap;

  Future<void> get() async {
    final maps = await DBHelper.get('to_do_list');
    _toDoList.addAll(List.generate(
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
        if (toDoItem.completeTime == null) {
          if (toDoItem.startTime.isSameDay(nowTime)) {
            _scheduleToDoListMap[ScheduleToDoListType.TodayUncompleted]!
                .list
                .add(toDoItem);
          } else if (toDoItem.startTime.isBefore(nowTime)) {
            _scheduleToDoListMap[ScheduleToDoListType.PastUncompleted]!
                .list
                .add(toDoItem);
          }
        } else if (toDoItem.completeTime!.isSameDay(nowTime)) {
          _scheduleToDoListMap[ScheduleToDoListType.TodayCompleted]!
              .list
              .add(toDoItem);
        }
        return toDoItem;
      },
    ));
    _scheduleToDoListMap.values.forEach((tdl) {
      tdl.list.sort(sortByStartTime);
      tdl.list.sort(sortByLevel);
    });
    notifyListeners();
  }

  void updateSchedule(ScheduleToDoListType type, int index) {
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
        update(toDoItem);
      },
    );
  }

  void deleteSchedule(ScheduleToDoListType type, int index) {
    final ToDoItem toDoItem = _scheduleToDoListMap[type]!.list.removeAt(index);
    _toDoList.remove(toDoItem);
    delete(toDoItem.id);
  }

  Future<void> insert(ToDoItem item) async {
    if (item.startTime.isBefore(nowTime)) {
      final list =
          _scheduleToDoListMap[ScheduleToDoListType.PastUncompleted]!.list;
      list.add(item);
      list.sort(sortByStartTime);
      list.sort(sortByLevel);
    } else if (item.startTime.isSameDay(nowTime)) {
      final list =
          _scheduleToDoListMap[ScheduleToDoListType.TodayUncompleted]!.list;
      list.add(item);
      list.sort(sortByStartTime);
      list.sort(sortByLevel);
    }
    _toDoList.add(item);

    await DBHelper.insert('to_do_list', item);
    notifyListeners();
  }

  Future<void> update(ToDoItem item) async {
    await DBHelper.update('to_do_list', item);
    notifyListeners();
  }

  Future<void> delete(int id) async {
    await DBHelper.delete('to_do_list', id);
    notifyListeners();
  }
}
