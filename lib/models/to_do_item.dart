import 'package:flutter/cupertino.dart';
import 'package:doit/constants/colors.dart';
import 'package:doit/constants/meas.dart';

enum ToDoItemLevel {
  I,
  II,
  III,
  IV,
}

enum ToDoItemType {
  Study,
  Work,
  Life,
  Health,
  Travel,
}

class ToDoItemAttribute {
  const ToDoItemAttribute({
    required this.icon,
    this.color = Colors.CompleteColor,
    required this.text,
  });

  final String icon;
  final Color color;
  final String text;
}

final toDoItemTypeMap = {
  ToDoItemType.Study: ToDoItemAttribute(
    icon: 'assets/images/study.svg',
    color: Colors.StudyColor,
    text: '学习',
  ),
  ToDoItemType.Work: ToDoItemAttribute(
    icon: 'assets/images/work.svg',
    color: Colors.WorkColor,
    text: '工作',
  ),
  ToDoItemType.Life: ToDoItemAttribute(
    icon: 'assets/images/life.svg',
    color: Colors.LifeColor,
    text: '生活',
  ),
  ToDoItemType.Health: ToDoItemAttribute(
    icon: 'assets/images/health.svg',
    color: Colors.HealthColor,
    text: '健康',
  ),
  ToDoItemType.Travel: ToDoItemAttribute(
    icon: 'assets/images/travel.svg',
    color: Colors.TravelColor,
    text: '旅行',
  ),
};

final toDoItemLevelMap = {
  ToDoItemLevel.I: ToDoItemAttribute(
    icon: 'assets/images/level_I.svg',
    color: Colors.ToDoItemLevelIColor,
    text: '重要且紧急',
  ),
  ToDoItemLevel.II: ToDoItemAttribute(
    icon: 'assets/images/level_I.svg',
    color: Colors.ToDoItemLevelIIColor,
    text: '重要不紧急',
  ),
  ToDoItemLevel.III: ToDoItemAttribute(
    icon: 'assets/images/level_III.svg',
    color: Colors.ToDoItemLevelIIIColor,
    text: '学习',
  ),
  ToDoItemLevel.IV: ToDoItemAttribute(
    icon: 'assets/images/level_IV.svg',
    color: Colors.ToDoItemLevelIVColor,
    text: '不重要不紧急',
  ),
};

class ToDoItem {
  const ToDoItem({
    required this.id,
    required this.title,
    this.remarks = '',
    required this.type,
    required this.level,
    this.to,
    this.from,
  });

  final int id;
  final String title;
  final String remarks;
  final ToDoItemType type;
  final ToDoItemLevel level;
  final DateTime? to;
  final DateTime? from;

  String get typeIcon =>
      toDoItemTypeMap[type]?.icon ?? toDoItemTypeMap[ToDoItemType.Life]!.icon;

  Color get typeColor => toDoItemTypeMap[type]?.color ?? Colors.CompleteColor;

  String get levelIcon =>
      toDoItemLevelMap[level]?.icon ?? toDoItemLevelMap[ToDoItemLevel.IV]!.icon;

  Color get levelColor =>
      toDoItemLevelMap[level]?.color ?? Colors.CompleteColor;

  String get levelText =>
      toDoItemLevelMap[level]?.text ?? toDoItemLevelMap[ToDoItemLevel.IV]!.text;
}
