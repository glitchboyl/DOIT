import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:doit/styles.dart';

enum ToDoItemStatus { a, b, c, d }

enum ToDoItemType { a, b, c, d }

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

String getItemTime({DateTime? to, DateTime? from}) {
  if (to == null) {
    return "每天重复";
  }
  var itemTime = "";
  var nowTime = DateTime.now();
  if (from != null && !from.isAfter(to)) {
    var getYear = !from.isSameYear(to);
    if (from.isSameDay(nowTime) && to.isSameDay(nowTime)) {
      itemTime += "今天";
    } else {
      itemTime +=
          "${getDateTime(from, getYear: getYear)} ${getClockTime(from)} - ${getDateTime(to, getYear: getYear)}";
    }
  } else if (to.isSameDay(nowTime)) {
    itemTime += "今天";
  } else {
    itemTime += getDateTime(to, getYear: !to.isSameYear(nowTime));
  }
  itemTime += " ${getClockTime(to)}";
  return itemTime;
}

class ToDoItem extends StatelessWidget {
  const ToDoItem(
    this.title, {
    this.type = ToDoItemType.a,
    this.status = ToDoItemStatus.a,
    this.to,
    this.from,
  });

  final String title;
  final ToDoItemType type;
  final ToDoItemStatus status;
  final DateTime? to;
  final DateTime? from;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CupertinoColors.white,
      ),
      height: 56,
      margin: const EdgeInsets.only(top: 12),
      child: Row(children: <Widget>[
        Container(
          width: 4,
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(2),
              bottomRight: Radius.circular(2),
            ),
            color: CupertinoColors.activeOrange,
          ),
        ),
        Container(
          width: 24,
          height: 24,
          margin: const EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: CupertinoColors.systemGreen,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Styles.ToDoItemTitleColor,
                fontSize: 14,
                // height: 20/14
              ),
            ),
            SizedBox(height: 2),
            Text(
              getItemTime(to: to, from: from),
              style: TextStyle(
                color: Styles.ToDoItemTimeColor,
                fontSize: 10,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
