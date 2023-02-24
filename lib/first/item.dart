import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

enum ItemStatus { a, b, c, d }

enum ItemType { a, b, c, d }

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

class ItemTime {
  const ItemTime({this.to, this.from});

  final DateTime? to;
  final DateTime? from;
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

String getItemTime(ItemTime time) {
  var to = time.to;
  var from = time.from;
  if (to == null) return "每天重复";
  var itemTime = "";
  var nowTime = DateTime.now();
  if (from != null) {
    var getYear = !from.isSameYear(to);
    if (!from.isSameYear(to)) if (from.isSameDay(nowTime) &&
        to.isSameDay(nowTime)) {
      itemTime += "今天";
    } else if (from.isBefore(to)) {
      itemTime +=
          "${getDateTime(from, getYear: getYear)} ${getClockTime(from)} - ${getDateTime(to, getYear: getYear)}}";
    }
  } else if (to.isSameDay(nowTime))
    itemTime += "今天";
  else
    itemTime += getDateTime(to);
  itemTime += " ${getClockTime(to)}";
  return itemTime;
}

class Item extends StatelessWidget {
  const Item(
    this.title, {
    this.type = ItemType.a,
    this.status = ItemStatus.a,
    required this.time,
  });

  final String title;
  final ItemType type;
  final ItemStatus status;
  final ItemTime time;

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
                color: Styles.ItemTitleColor,
                fontSize: 14,
                // height: 20/14
              ),
            ),
            SizedBox(
              height: 2
            ),
            Text(
              getItemTime(time),
              style: TextStyle(
                color: Styles.ItemTimeColor,
                fontSize: 10,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
