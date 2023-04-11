import 'package:flutter/material.dart';
import 'property.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';

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

enum NotificationType {
  None,
  RightTime,
  FiveMinutesEarlier,
  ThirtyMinutesEarlier,
  OneHourEarlier,
  OneDayEarlier,
}

enum RepeatType {
  Never,
  EveryDay,
  EveryWeek,
  EveryMonth,
  EveryYear,
}

final toDoItemTypeMap = {
  ToDoItemType.Study: Property(
    icon: Ico.Study,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.StudyColor
        : LightStyles.StudyColor,
    text: '学习',
  ),
  ToDoItemType.Work: Property(
    icon: Ico.Work,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.WorkColor
        : LightStyles.WorkColor,
    text: '工作',
  ),
  ToDoItemType.Life: Property(
    icon: Ico.Life,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.LifeColor
        : LightStyles.LifeColor,
    text: '生活',
  ),
  ToDoItemType.Health: Property(
    icon: Ico.Health,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.HealthColor
        : LightStyles.HealthColor,
    text: '健康',
  ),
  ToDoItemType.Travel: Property(
    icon: Ico.Travel,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.TravelColor
        : LightStyles.TravelColor,
    text: '旅行',
  ),
};

final toDoItemLevelMap = {
  ToDoItemLevel.I: Property(
    icon: Ico.LevelI,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.ToDoItemLevelIColor
        : LightStyles.ToDoItemLevelIColor,
    text: '重要且紧急',
  ),
  ToDoItemLevel.II: Property(
    icon: Ico.LevelII,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.ToDoItemLevelIIColor
        : LightStyles.ToDoItemLevelIIColor,
    text: '重要不紧急',
  ),
  ToDoItemLevel.III: Property(
    icon: Ico.LevelIII,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.ToDoItemLevelIIIColor
        : LightStyles.ToDoItemLevelIIIColor,
    text: '不重要紧急',
  ),
  ToDoItemLevel.IV: Property(
    icon: Ico.LevelIV,
    color: (context) => Theme.of(context).brightness == Brightness.dark
        ? DarkStyles.ToDoItemLevelIVColor
        : LightStyles.ToDoItemLevelIVColor,
    text: '不重要不紧急',
  ),
};

const Map<NotificationType, List<dynamic>> notificationTypeMap = {
  NotificationType.None: [
    '无',
    null,
  ],
  NotificationType.RightTime: [
    '准时',
    const Duration(seconds: 0),
  ],
  NotificationType.FiveMinutesEarlier: [
    '提前5分钟',
    const Duration(minutes: 5),
  ],
  NotificationType.ThirtyMinutesEarlier: [
    '提前30分钟',
    const Duration(minutes: 30),
  ],
  NotificationType.OneHourEarlier: [
    '提前1小时',
    const Duration(hours: 1),
  ],
  NotificationType.OneDayEarlier: [
    '提前1天',
    const Duration(days: 1),
  ],
};

class ToDoItem {
  ToDoItem({
    required this.id,
    required this.title,
    this.remarks = '',
    required this.type,
    required this.level,
    required this.startTime,
    required this.endTime,
    this.repeatType = RepeatType.Never,
    this.notificationType = NotificationType.None,
    this.completeTime,
  });

  final int id;
  String title;
  String remarks;
  ToDoItemType type;
  ToDoItemLevel level;
  DateTime startTime;
  DateTime endTime;
  RepeatType repeatType;
  NotificationType notificationType;
  DateTime? completeTime;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'remarks': remarks,
      'type': type.index,
      'level': level.index,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'repeatType': repeatType.index,
      'notificationType': notificationType.index,
      'completeTime': completeTime?.millisecondsSinceEpoch,
    };
  }

  String get typeIcon =>
      toDoItemTypeMap[type]?.icon ?? toDoItemTypeMap[ToDoItemType.Life]!.icon;

  Color typeColor(BuildContext context) => completeTime != null
      ? Theme.of(context).brightness == Brightness.dark
          ? DarkStyles.DeactivedColor
          : LightStyles.DeactivedColor
      : toDoItemTypeMap[type]!.color(context);

  String get typeText =>
      toDoItemTypeMap[type]?.text ?? toDoItemTypeMap[ToDoItemType.Life]!.text;

  String get levelIcon =>
      toDoItemLevelMap[level]?.icon ?? toDoItemLevelMap[ToDoItemLevel.IV]!.icon;

  Color levelColor(BuildContext context) => completeTime != null
      ? Theme.of(context).brightness == Brightness.dark
          ? DarkStyles.DeactivedColor
          : LightStyles.DeactivedColor
      : toDoItemLevelMap[level]!.color(context);

  String get levelText =>
      toDoItemLevelMap[level]?.text ?? toDoItemLevelMap[ToDoItemLevel.IV]!.text;

  String get repeatText {
    switch (repeatType) {
      case RepeatType.EveryYear:
        return '每年重复';
      case RepeatType.EveryMonth:
        return '每月重复';
      case RepeatType.EveryWeek:
        return '每周重复';
      case RepeatType.EveryDay:
        return '每天重复';
      case RepeatType.Never:
      default:
        return '';
    }
  }
}

final sortByStartTime =
    (ToDoItem a, ToDoItem b) => a.startTime.compareTo(b.startTime);

final sortByLevel =
    (ToDoItem a, ToDoItem b) => a.level.index.compareTo(b.level.index);
