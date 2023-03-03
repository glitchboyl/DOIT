import 'package:flutter/material.dart';
import 'to_do_item.dart';

enum ScheduleToDoListType {
  PastUncompleted,
  TodayUncompleted,
  TodayCompleted,
}

class ScheduleToDoList {
  const ScheduleToDoList({
    required this.title,
    required this.list,
  });

  final String title;
  final List<ToDoItem> list;
}

final Map<ScheduleToDoListType, ScheduleToDoList> scheduleToDoListMap = {
  ScheduleToDoListType.PastUncompleted: ScheduleToDoList(
    title: '过去',
    list: [
      ToDoItem(
        id: UniqueKey(),
        title: '健身计划开始。',
        type: ToDoItemType.Life,
        level: ToDoItemLevel.I,
        startTime: DateTime(2022, 7, 10, 19),
        endTime: DateTime(2022, 7, 10, 19),
      ),
    ],
  ),
  ScheduleToDoListType.TodayUncompleted: ScheduleToDoList(
    title: '今天',
    list: [
      ToDoItem(
        id: UniqueKey(),
        title: '看书看书看书!!!',
        type: ToDoItemType.Study,
        level: ToDoItemLevel.II,
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        repeatType: RepeatType.EveryDay,
      ),
      ToDoItem(
        id: UniqueKey(),
        title: '记得写实习报告!!!!',
        type: ToDoItemType.Study,
        level: ToDoItemLevel.I,
        startTime: DateTime(2023, 2, 10, 9),
        endTime: DateTime(2023, 2, 17, 9),
      ),
    ],
  ),
  ScheduleToDoListType.TodayCompleted: ScheduleToDoList(
    title: '已完成',
    list: [
      ToDoItem(
        id: UniqueKey(),
        title: '整理需求文档',
        type: ToDoItemType.Study,
        level: ToDoItemLevel.II,
        startTime: DateTime(2023, 3, 2, 8),
        endTime: DateTime(2023, 3, 2, 8),
        completeTime: DateTime.now(),
      ),
    ],
  ),
};
