import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:doit/models/bookkeeping.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'db.dart';
import 'package:doit/utils/time.dart';

class BookkeepingProvider extends ChangeNotifier {
  final List<BookkeepingItem> _bookkeepingList = [];
  final Map<DateTime, List<BookkeepingItem>> _bookkeepingListMap = {};
  final Map<BookkeepingStatisticType,
          Map<DateTime, List<Map<BookkeepingItemCategory, double>>>>
      _statisticsMap = {
    BookkeepingStatisticType.Day: {},
    BookkeepingStatisticType.Month: {},
    BookkeepingStatisticType.Year: {},
  };
  DateTime _focusedMonth = DateTime(nowTime.year, nowTime.month);
  BookkeepingItem? _fresh;

  List<BookkeepingItem> get bookkeepingList => _bookkeepingList;
  Map<DateTime, List<BookkeepingItem>> get bookkeepingListMap =>
      _bookkeepingListMap;
  Map<BookkeepingStatisticType,
          Map<DateTime, List<Map<BookkeepingItemCategory, double>>>>
      get statisticsMap => _statisticsMap;
  DateTime get focusedMonth => _focusedMonth;
  BookkeepingItem? get fresh => _fresh;

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
            category: BookkeepingItemCategory.values[item['category']],
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
    _fresh = item;
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
    final bookkeepingYear = DateTime(
      item.time.year,
    );
    final bookkeepingMonth = DateTime(
      bookkeepingYear.year,
      item.time.month,
    );
    final bookkeepingDay = DateTime(
      bookkeepingMonth.year,
      bookkeepingMonth.month,
      item.time.day,
    );

    if (_bookkeepingListMap[bookkeepingDay] == null) {
      _bookkeepingListMap[bookkeepingDay] = [];
    }
    _bookkeepingListMap[bookkeepingDay]!.add(item);

    // statistic day
    if (_statisticsMap[BookkeepingStatisticType.Day]![bookkeepingDay] == null) {
      _statisticsMap[BookkeepingStatisticType.Day]![bookkeepingDay] = [{}, {}];
    }
    if (_statisticsMap[BookkeepingStatisticType.Day]![bookkeepingDay]![
            item.type.index][item.category] ==
        null) {
      _statisticsMap[BookkeepingStatisticType.Day]![bookkeepingDay]![
          item.type.index][item.category] = 0;
    }
    _statisticsMap[BookkeepingStatisticType.Day]![bookkeepingDay]![item.type
        .index][item.category] = _statisticsMap[BookkeepingStatisticType.Day]![
            bookkeepingDay]![item.type.index][item.category]! +
        item.amount;

    // statistic month
    if (_statisticsMap[BookkeepingStatisticType.Month]![bookkeepingMonth] ==
        null) {
      _statisticsMap[BookkeepingStatisticType.Month]![bookkeepingMonth] = [
        {},
        {}
      ];
    }
    if (_statisticsMap[BookkeepingStatisticType.Month]![bookkeepingMonth]![
            item.type.index][item.category] ==
        null) {
      _statisticsMap[BookkeepingStatisticType.Month]![bookkeepingMonth]![
          item.type.index][item.category] = 0;
    }
    _statisticsMap[BookkeepingStatisticType.Month]![bookkeepingMonth]![
            item.type.index][item.category] =
        _statisticsMap[BookkeepingStatisticType.Month]![bookkeepingMonth]![
                item.type.index][item.category]! +
            item.amount;

    // statistic year
    if (_statisticsMap[BookkeepingStatisticType.Year]![bookkeepingYear] ==
        null) {
      _statisticsMap[BookkeepingStatisticType.Year]![bookkeepingYear] = [
        {},
        {}
      ];
    }
    if (_statisticsMap[BookkeepingStatisticType.Year]![bookkeepingYear]![
            item.type.index][item.category] ==
        null) {
      _statisticsMap[BookkeepingStatisticType.Year]![bookkeepingYear]![
          item.type.index][item.category] = 0;
    }
    _statisticsMap[BookkeepingStatisticType.Year]![bookkeepingYear]![item.type
        .index][item.category] = _statisticsMap[BookkeepingStatisticType.Year]![
            bookkeepingYear]![item.type.index][item.category]! +
        item.amount;
  }

  void reduce(BookkeepingItem oldItem) {
    final bookkeepingYear = DateTime(
      oldItem.time.year,
    );
    final bookkeepingMonth = DateTime(
      bookkeepingYear.year,
      oldItem.time.month,
    );
    final bookkeepingDay = DateTime(
      bookkeepingMonth.year,
      bookkeepingMonth.month,
      oldItem.time.day,
    );

    // reduce day
    _statisticsMap[BookkeepingStatisticType.Day]![bookkeepingDay]![
            oldItem.type.index][oldItem.category] =
        _statisticsMap[BookkeepingStatisticType.Day]![bookkeepingDay]![
                oldItem.type.index][oldItem.category]! -
            oldItem.amount;

    // reduce month
    _statisticsMap[BookkeepingStatisticType.Month]![bookkeepingMonth]![
            oldItem.type.index][oldItem.category] =
        _statisticsMap[BookkeepingStatisticType.Month]![bookkeepingMonth]![
                oldItem.type.index][oldItem.category]! -
            oldItem.amount;

    // reduce year
    _statisticsMap[BookkeepingStatisticType.Year]![bookkeepingYear]![
            oldItem.type.index][oldItem.category] =
        _statisticsMap[BookkeepingStatisticType.Year]![bookkeepingYear]![
                oldItem.type.index][oldItem.category]! -
            oldItem.amount;

    _bookkeepingListMap[bookkeepingDay]!.remove(oldItem);
  }

  void focus(DateTime month) => {
        _focusedMonth = month,
        notifyListeners(),
      };

  void refresh() => _fresh = null;
}
