import 'package:doit/models/to_do_item.dart';

extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime date) {
    return this.year.toString() == date.year.toString() &&
        this.month.toString() == date.month.toString() &&
        this.day.toString() == date.day.toString();
  }

  bool isSameYear(DateTime date) {
    return this.year.toString() == date.year.toString();
  }
}

String fillZero(int n) => n < 10 ? "0" : "";
String getClockTime(DateTime time) {
  var hour = time.hour;
  var minute = time.minute;
  return "${fillZero(hour)}${hour.toString()}:${fillZero(minute)}${minute.toString()}";
}

String getDateTime(DateTime time, {bool getYear = false}) {
  var month = time.month;
  var day = time.day;
  return "${getYear ? time.year.toString() + ' ' : ''}${fillZero(month)}${month.toString()}.${fillZero(day)}${day.toString()}";
}

String getToDoItemTime(
  DateTime startTime,
  DateTime endTime,
) {
  String timeText = "";
  final DateTime nowTime = DateTime.now();

  if (startTime.isAfter(endTime)) {
    endTime = startTime;
  }
  timeText +=
      "${startTime.isSameDay(nowTime) ? '今天' : getDateTime(startTime, getYear: !startTime.isSameYear(nowTime))} ${getClockTime(startTime)}";
  if (startTime != endTime) {
    timeText +=
        " - ${endTime.isSameDay(startTime) ? '' : endTime.isSameDay(nowTime) ? '今天' : getDateTime(endTime, getYear: !endTime.isSameYear(nowTime))} ${getClockTime(endTime)}";
  }
  return timeText;
}
