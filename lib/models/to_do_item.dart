import 'package:flutter/material.dart';
import 'property.dart';
import 'package:doit/providers/theme.dart';
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
    icon: (context) => Ico.Study,
    color: (context) =>
        isDarkMode(context) ? DarkStyles.StudyColor : LightStyles.StudyColor,
    text: '学习',
  ),
  ToDoItemType.Work: Property(
    icon: (context) => Ico.Work,
    color: (context) =>
        isDarkMode(context) ? DarkStyles.WorkColor : LightStyles.WorkColor,
    text: '工作',
  ),
  ToDoItemType.Life: Property(
    icon: (context) => Ico.Life,
    color: (context) =>
        isDarkMode(context) ? DarkStyles.LifeColor : LightStyles.LifeColor,
    text: '生活',
  ),
  ToDoItemType.Health: Property(
    icon: (context) => Ico.Health,
    color: (context) =>
        isDarkMode(context) ? DarkStyles.HealthColor : LightStyles.HealthColor,
    text: '健康',
  ),
  ToDoItemType.Travel: Property(
    icon: (context) => Ico.Travel,
    color: (context) =>
        isDarkMode(context) ? DarkStyles.TravelColor : LightStyles.TravelColor,
    text: '旅行',
  ),
};

final toDoItemLevelMap = {
  ToDoItemLevel.I: Property(
    icon: (context) => Ico.LevelI,
    color: (context) => isDarkMode(context)
        ? DarkStyles.ToDoItemLevelIColor
        : LightStyles.ToDoItemLevelIColor,
    text: '重要且紧急',
  ),
  ToDoItemLevel.II: Property(
    icon: (context) => Ico.LevelII,
    color: (context) => isDarkMode(context)
        ? DarkStyles.ToDoItemLevelIIColor
        : LightStyles.ToDoItemLevelIIColor,
    text: '重要不紧急',
  ),
  ToDoItemLevel.III: Property(
    icon: (context) => Ico.LevelIII,
    color: (context) => isDarkMode(context)
        ? DarkStyles.ToDoItemLevelIIIColor
        : LightStyles.ToDoItemLevelIIIColor,
    text: '不重要紧急',
  ),
  ToDoItemLevel.IV: Property(
    icon: (context) => Ico.LevelIV,
    color: (context) => isDarkMode(context)
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

  String typeIcon(BuildContext context) =>
      toDoItemTypeMap[type]?.icon(context) ??
      toDoItemTypeMap[ToDoItemType.Life]!.icon(context);

  Color typeColor(BuildContext context) => completeTime != null
      ? Theme.of(context).colorScheme.deactivedColor
      : toDoItemTypeMap[type]!.color(context);

  String get typeText =>
      toDoItemTypeMap[type]?.text ?? toDoItemTypeMap[ToDoItemType.Life]!.text;

  String levelIcon(BuildContext context) =>
      toDoItemLevelMap[level]?.icon(context) ??
      toDoItemLevelMap[ToDoItemLevel.IV]!.icon(context);

  Color levelColor(BuildContext context) => completeTime != null
      ? Theme.of(context).colorScheme.deactivedColor
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
