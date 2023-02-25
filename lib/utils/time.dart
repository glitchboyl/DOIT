
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

String getToDoItemTime({DateTime? to, DateTime? from}) {
  if (to == null) {
    return "每天重复";
  }
  var time = "";
  var nowTime = DateTime.now();
  if (from != null && !from.isAfter(to)) {
    var getYear = !from.isSameYear(to);
    if (from.isSameDay(nowTime) && to.isSameDay(nowTime)) {
      time += "今天";
    } else {
      time +=
          "${getDateTime(from, getYear: getYear)} ${getClockTime(from)} - ${getDateTime(to, getYear: getYear)}";
    }
  } else if (to.isSameDay(nowTime)) {
    time += "今天";
  } else {
    time += getDateTime(to, getYear: !to.isSameYear(nowTime));
  }
  time += " ${getClockTime(to)}";
  return time;
}