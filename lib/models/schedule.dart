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