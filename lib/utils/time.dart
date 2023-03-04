final DateTime nowTime = DateTime.now();

extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime date) =>
      this.year.toString() == date.year.toString() &&
      this.month.toString() == date.month.toString() &&
      this.day.toString() == date.day.toString();

  bool isSameMonth(DateTime date) =>
      this.month.toString() == date.month.toString();

  bool isSameYear(DateTime date) =>
      this.year.toString() == date.year.toString();
}

String fillDateZero(int n) => '${n < 10 ? "0" : ""}${n.toString()}';
String getClockTime(DateTime time) {
  var hour = time.hour;
  var minute = time.minute;
  return "${fillDateZero(hour)}:${fillDateZero(minute)}";
}

String getDateTime(DateTime time) {
  var month = time.month;
  var day = time.day;
  return "${!time.isSameYear(nowTime) ? time.year.toString() + ' ' : ''}${fillDateZero(month)}.${fillDateZero(day)}";
}

String getToDoItemTime(
  DateTime startTime,
  DateTime endTime,
) {
  String timeText = "";
  if (startTime.isAfter(endTime)) {
    endTime = startTime;
  }
  timeText +=
      "${startTime.isSameDay(nowTime) ? '今天' : getDateTime(startTime)} ${getClockTime(startTime)}";
  if (startTime != endTime) {
    timeText +=
        " - ${endTime.isSameDay(startTime) ? '' : endTime.isSameDay(nowTime) ? '今天' : getDateTime(endTime)} ${getClockTime(endTime)}";
  }
  return timeText;
}

String getNoteTime(DateTime publishTime) =>
    "${getDateTime(publishTime)} ${getClockTime(publishTime)}";
