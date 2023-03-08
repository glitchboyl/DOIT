import 'package:flutter/material.dart';

enum BookkeepingItemType {
  Incomes,
  Expenses
}

class BookkeepingItem {
  const BookkeepingItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.time,
  });

  final int id;
  final String title;
  final double amount;
  final BookkeepingItemType type;
  final DateTime time;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': BookkeepingItemType.values.indexOf(type),
      'time': time.millisecondsSinceEpoch,
    };
  }
}

final Map<DateTime, List<BookkeepingItem>> bookkeepingMap = {
  DateTime(2023, 3, 1): [
    BookkeepingItem(
      id: UniqueKey().hashCode,
      title: 'ass we can',
      amount: 100,
      type: BookkeepingItemType.Incomes,
      time: DateTime(2023, 3, 1, 5),
    ),
  ],
  DateTime(2023, 3, 2): [
    BookkeepingItem(
      id: UniqueKey().hashCode,
      title: 'boy next door',
      amount: 100,
      type: BookkeepingItemType.Expenses,
      time: DateTime(2023, 3, 2, 6),
    ),
  ],
  DateTime.now(): [
    BookkeepingItem(
      id: UniqueKey().hashCode,
      title: 'thank you sir',
      amount: 100,
      type: BookkeepingItemType.Incomes,
      time: DateTime.now(),
    ),
  ]
};

final sortByTime =
    (BookkeepingItem a, BookkeepingItem b) => a.time.compareTo(b.time);