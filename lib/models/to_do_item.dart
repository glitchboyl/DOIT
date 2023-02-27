import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';
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
    this.color = Styles.CompleteColor,
    required this.text,
  });

  final String icon;
  final Color color;
  final String text;
}

final toDoItemTypeMap = {
  ToDoItemType.Study: ToDoItemAttribute(
    icon: 'assets/images/study.svg',
    color: Styles.StudyColor,
    text: '学习',
  ),
  ToDoItemType.Work: ToDoItemAttribute(
    icon: 'assets/images/work.svg',
    color: Styles.WorkColor,
    text: '工作',
  ),
  ToDoItemType.Life: ToDoItemAttribute(
    icon: 'assets/images/life.svg',
    color: Styles.LifeColor,
    text: '生活',
  ),
  ToDoItemType.Health: ToDoItemAttribute(
    icon: 'assets/images/health.svg',
    color: Styles.HealthColor,
    text: '健康',
  ),
  ToDoItemType.Travel: ToDoItemAttribute(
    icon: 'assets/images/travel.svg',
    color: Styles.TravelColor,
    text: '旅行',
  ),
};

final toDoItemLevelMap = {
  ToDoItemLevel.I: ToDoItemAttribute(
    icon: 'assets/images/level_I.svg',
    color: Styles.ToDoItemLevelIColor,
    text: '重要且紧急',
  ),
  ToDoItemLevel.II: ToDoItemAttribute(
    icon: 'assets/images/level_I.svg',
    color: Styles.ToDoItemLevelIIColor,
    text: '重要不紧急',
  ),
  ToDoItemLevel.III: ToDoItemAttribute(
    icon: 'assets/images/level_III.svg',
    color: Styles.ToDoItemLevelIIIColor,
    text: '学习',
  ),
  ToDoItemLevel.IV: ToDoItemAttribute(
    icon: 'assets/images/level_IV.svg',
    color: Styles.ToDoItemLevelIVColor,
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

  Color get typeColor => toDoItemTypeMap[type]?.color ?? Styles.CompleteColor;

  String get typeText =>
      toDoItemTypeMap[type]?.text ?? toDoItemTypeMap[ToDoItemType.Life]!.text;

  String get levelIcon =>
      toDoItemLevelMap[level]?.icon ?? toDoItemLevelMap[ToDoItemLevel.IV]!.icon;

  Color get levelColor =>
      toDoItemLevelMap[level]?.color ?? Styles.CompleteColor;

  String get levelText =>
      toDoItemLevelMap[level]?.text ?? toDoItemLevelMap[ToDoItemLevel.IV]!.text;
}
