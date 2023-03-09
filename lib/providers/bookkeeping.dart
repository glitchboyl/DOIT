import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'db.dart';
import 'package:doit/utils/time.dart';

class BookkeepingProvider extends ChangeNotifier {
  final List<BookkeepingItem> _bookkeepingList = [];
  final Map<DateTime, List<BookkeepingItem>> _bookkeepingListMap = {};
  final Map<DateTime, List<double>> _statisticsMap = {};
  DateTime _focusedMonth = DateTime(nowTime.year, nowTime.month);

  List<BookkeepingItem> get bookkeepingList => _bookkeepingList;
  Map<DateTime, List<BookkeepingItem>> get bookkeepingListMap =>
      _bookkeepingListMap;
  Map<DateTime, List<double>> get statisticsMap => _statisticsMap;
  DateTime get focusedMonth => _focusedMonth;

  Future<void> get() async {
    final maps = await DBHelper.get('bookkeeping_list');
    _bookkeepingList.addAll(
      List.generate(
        maps.length,
        (i) {
          final item = maps[i];
          final bookkeepingItem = BookkeepingItem(
            id: item['id'],
            title: item['title'],
            amount: double.tryParse(item['amount']) ?? 0,
            time: DateTime.fromMillisecondsSinceEpoch(item['time']),
            type: BookkeepingItemType.values[item['type']],
          );
          statistic(bookkeepingItem);
          return bookkeepingItem;
        },
      ),
    );
    _bookkeepingListMap.values.forEach((list) {
      list.sort(sortByTime);
    });
    notifyListeners();
  }

  Future<void> insert(BookkeepingItem item) async {
    _bookkeepingList.add(item);
    final bookkeepingDay = DateTime(
      item.time.year,
      item.time.month,
      item.time.day,
    );
    statistic(item);
    _bookkeepingListMap[bookkeepingDay]!.sort(sortByTime);
    await DBHelper.insert('bookkeeping_list', item);
    if (!item.time.isSameMonth(_focusedMonth)) {
      _focusedMonth = DateTime(item.time.year, item.time.month);
    }
    notifyListeners();
  }

  Future<void> update(BookkeepingItem item) async {
    statistic(item);
    await DBHelper.update('bookkeeping_list', item);
    notifyListeners();
  }

  Future<void> delete(BookkeepingItem item) async {
    _bookkeepingList.remove(item);
    reduce(item);
    final bookkeepingDay = DateTime(
      item.time.year,
      item.time.month,
      item.time.day,
    );
    _bookkeepingListMap[bookkeepingDay]!.remove(item);
    if (_bookkeepingListMap[bookkeepingDay]!.length == 0) {
      _bookkeepingListMap.remove(bookkeepingDay);
    }
    await DBHelper.delete('bookkeeping_list', item.id);
    notifyListeners();
  }

  void statistic(BookkeepingItem item) {
    final bookkeepingMonth = DateTime(
      item.time.year,
      item.time.month,
    );
    final bookkeepingDay = DateTime(
      bookkeepingMonth.year,
      bookkeepingMonth.month,
      item.time.day,
    );
    final typeIndex = BookkeepingItemType.values.indexOf(item.type);
    if (_bookkeepingListMap[bookkeepingDay] == null) {
      _bookkeepingListMap[bookkeepingDay] = [];
    }
    _bookkeepingListMap[bookkeepingDay]!.add(item);
    if (_statisticsMap[bookkeepingMonth] == null) {
      _statisticsMap[bookkeepingMonth] = [0, 0];
    }
    _statisticsMap[bookkeepingMonth]![typeIndex] += item.amount;
    if (_statisticsMap[bookkeepingDay] == null) {
      _statisticsMap[bookkeepingDay] = [0, 0];
    }
    _statisticsMap[bookkeepingDay]![typeIndex] += item.amount;
  }

  void reduce(BookkeepingItem oldItem) {
    final bookkeepingMonth = DateTime(
      oldItem.time.year,
      oldItem.time.month,
    );
    final bookkeepingDay = DateTime(
      bookkeepingMonth.year,
      bookkeepingMonth.month,
      oldItem.time.day,
    );
    final typeIndex = BookkeepingItemType.values.indexOf(oldItem.type);
    _statisticsMap[bookkeepingMonth]![typeIndex] -= oldItem.amount;
    _statisticsMap[bookkeepingDay]![typeIndex] -= oldItem.amount;
  }

  void focus(DateTime month) => {
        _focusedMonth = month,
        notifyListeners(),
      };
}
