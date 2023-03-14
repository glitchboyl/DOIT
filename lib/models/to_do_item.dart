import 'package:flutter/material.dart';
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

class ToDoItemProperty {
  const ToDoItemProperty({
    required this.icon,
    this.color = Styles.DeactivedColor,
    required this.text,
  });

  final String icon;
  final Color color;
  final String text;
}

const toDoItemTypeMap = {
  ToDoItemType.Study: ToDoItemProperty(
    icon: 'assets/images/study.svg',
    color: Styles.StudyColor,
    text: '学习',
  ),
  ToDoItemType.Work: ToDoItemProperty(
    icon: 'assets/images/work.svg',
    color: Styles.WorkColor,
    text: '工作',
  ),
  ToDoItemType.Life: ToDoItemProperty(
    icon: 'assets/images/life.svg',
    color: Styles.LifeColor,
    text: '生活',
  ),
  ToDoItemType.Health: ToDoItemProperty(
    icon: 'assets/images/health.svg',
    color: Styles.HealthColor,
    text: '健康',
  ),
  ToDoItemType.Travel: ToDoItemProperty(
    icon: 'assets/images/travel.svg',
    color: Styles.TravelColor,
    text: '旅行',
  ),
};

const toDoItemLevelMap = {
  ToDoItemLevel.I: ToDoItemProperty(
    icon: 'assets/images/level_I.svg',
    color: Styles.ToDoItemLevelIColor,
    text: '重要且紧急',
  ),
  ToDoItemLevel.II: ToDoItemProperty(
    icon: 'assets/images/level_I.svg',
    color: Styles.ToDoItemLevelIIColor,
    text: '重要不紧急',
  ),
  ToDoItemLevel.III: ToDoItemProperty(
    icon: 'assets/images/level_III.svg',
    color: Styles.ToDoItemLevelIIIColor,
    text: '不重要紧急',
  ),
  ToDoItemLevel.IV: ToDoItemProperty(
    icon: 'assets/images/level_IV.svg',
    color: Styles.ToDoItemLevelIVColor,
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
      'type': ToDoItemType.values.indexOf(type),
      'level': ToDoItemLevel.values.indexOf(level),
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'repeatType': RepeatType.values.indexOf(repeatType),
      'notificationType': NotificationType.values.indexOf(notificationType),
      'completeTime': completeTime?.millisecondsSinceEpoch,
    };
  }

  String get typeIcon =>
      toDoItemTypeMap[type]?.icon ?? toDoItemTypeMap[ToDoItemType.Life]!.icon;

  Color get typeColor => completeTime != null
      ? Styles.DeactivedColor
      : (toDoItemTypeMap[type]?.color ?? Styles.DeactivedColor);

  String get typeText =>
      toDoItemTypeMap[type]?.text ?? toDoItemTypeMap[ToDoItemType.Life]!.text;

  String get levelIcon =>
      toDoItemLevelMap[level]?.icon ?? toDoItemLevelMap[ToDoItemLevel.IV]!.icon;

  Color get levelColor => completeTime != null
      ? Styles.DeactivedColor
      : toDoItemLevelMap[level]?.color ?? Styles.DeactivedColor;

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

final sortByLevel = (ToDoItem a, ToDoItem b) => ToDoItemLevel.values
    .indexOf(a.level)
    .compareTo(ToDoItemLevel.values.indexOf(b.level));
