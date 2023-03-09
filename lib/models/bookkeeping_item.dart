import 'package:flutter/material.dart';

enum BookkeepingItemType {
  Incomes,
  Expenses
}

class BookkeepingItem {
  BookkeepingItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.time,
  });

  final int id;
  String title;
  double amount;
  BookkeepingItemType type;
  DateTime time;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount.toString(),
      'type': BookkeepingItemType.values.indexOf(type),
      'time': time.millisecondsSinceEpoch,
    };
  }
}

final sortByTime =
    (BookkeepingItem a, BookkeepingItem b) => a.time.compareTo(b.time);