import 'dart:async';
import 'package:doit/utils/time.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/models/schedule.dart';

final sortByDate =
    (ToDoItem a, ToDoItem b) => a.startTime.compareTo(b.startTime);

class ToDoListProvider extends ChangeNotifier {
  late Future<Database> _db;
  bool _isConnected = false;
  final List<ToDoItem> _toDoList = [];
  final Map<ScheduleToDoListType, ScheduleToDoList> _scheduleToDoListMap = {
    ScheduleToDoListType.PastUncompleted: ScheduleToDoList(
      title: '过去',
      list: [
        // ToDoItem(
        //   id: UniqueKey().hashCode,
        //   title: '健身计划开始。',
        //   type: ToDoItemType.Life,
        //   level: ToDoItemLevel.I,
        //   startTime: DateTime(2022, 7, 10, 19),
        //   endTime: DateTime(2022, 7, 10, 19),
        // ),
      ],
    ),
    ScheduleToDoListType.TodayUncompleted: ScheduleToDoList(
      title: '今天',
      list: [
        // ToDoItem(
        //   id: UniqueKey().hashCode,
        //   title: '看书看书看书看书看书看书看书看书看书看书看书看书看书看书看书看书看书看书!!!',
        //   type: ToDoItemType.Study,
        //   level: ToDoItemLevel.II,
        //   startTime: DateTime.now(),
        //   endTime: DateTime.now(),
        //   repeatType: RepeatType.EveryDay,
        // ),
        // ToDoItem(
        //   id: UniqueKey().hashCode,
        //   title: '记得写实习报告!!!!',
        //   type: ToDoItemType.Study,
        //   level: ToDoItemLevel.I,
        //   startTime: DateTime(2023, 2, 10, 9),
        //   endTime: DateTime(2023, 2, 17, 9),
        // ),
      ],
    ),
    ScheduleToDoListType.TodayCompleted: ScheduleToDoList(
      title: '已完成',
      list: [
        // ToDoItem(
        //   id: UniqueKey().hashCode,
        //   title: '整理需求文档',
        //   type: ToDoItemType.Study,
        //   level: ToDoItemLevel.II,
        //   startTime: DateTime(2023, 3, 2, 8),
        //   endTime: DateTime(2023, 3, 2, 8),
        //   completeTime: DateTime.now(),
        // ),
      ],
    ),
  };

  List<ToDoItem> get toDoList => _toDoList;
  Map<ScheduleToDoListType, ScheduleToDoList> get scheduleToDoListMap =>
      _scheduleToDoListMap;

  connectDB() async {
    if (!_isConnected) {
      WidgetsFlutterBinding.ensureInitialized();
      _db = openDatabase(
        join(await getDatabasesPath(), 'doit_database.db'),
        onCreate: (db, version) {
          // create table
          // db.execute(
          //   'CREATE TABLE notes(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
          // );
          // db.execute(
          //   'CREATE TABLE bookkeeping_list(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
          // );
          return db.execute(
            'CREATE TABLE to_do_list(id INTEGER PRIMARY KEY, title TEXT, remarks TEXT, type INTEGER, level, startTime INTEGER, endTime INTEGER, repeatType INTEGER, completeTime INTEGER)',
          );
        },
        version: 1,
      );
      _isConnected = true;
    }
    await getData();
  }

  getData() async {
    final db = await _db;

    final List<Map<String, dynamic>> maps = await db.query('to_do_list');

    _toDoList.addAll(List.generate(
      maps.length,
      (i) {
        final item = maps[i];
        return ToDoItem(
          id: item['id'],
          title: item['title'],
          remarks: item['remarks'],
          type: ToDoItemType.values[item['type']],
          level: ToDoItemLevel.values[item['level']],
          startTime: DateTime.fromMillisecondsSinceEpoch(item['startTime']),
          endTime: DateTime.fromMillisecondsSinceEpoch(item['endTime']),
          repeatType: RepeatType.values[item['repeatType']],
          completeTime: item['completeTime'] != null
              ? DateTime.fromMillisecondsSinceEpoch(item['completeTime'])
              : null,
        );
      },
    ));
    _toDoList.sort(sortByDate);
    for (int i = 0; i < _toDoList.length; i++) {
      if (_toDoList[i].completeTime == null) {
        if (_toDoList[i].startTime.isSameDay(nowTime)) {
          _scheduleToDoListMap[ScheduleToDoListType.TodayUncompleted]!
              .list
              .add(_toDoList[i]);
        } else if (_toDoList[i].startTime.isBefore(nowTime)) {
          _scheduleToDoListMap[ScheduleToDoListType.PastUncompleted]!
              .list
              .add(_toDoList[i]);
        }
      } else if (_toDoList[i].completeTime!.isSameDay(nowTime)) {
        _scheduleToDoListMap[ScheduleToDoListType.TodayCompleted]!
            .list
            .add(_toDoList[i]);
      }
    }
    notifyListeners();
  }

  void updateSchedule(ScheduleToDoListType type, int index) {
    final ToDoItem toDoItem = _scheduleToDoListMap[type]!.list.removeAt(index);
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 1), () {
      if (toDoItem.completeTime == null) {
        toDoItem.completeTime = DateTime.now();
        final list =
            _scheduleToDoListMap[ScheduleToDoListType.TodayCompleted]!.list;
        list.add(toDoItem);
        list.sort(sortByDate);
      } else {
        toDoItem.completeTime = null;
        final list = (scheduleToDoListMap[toDoItem.startTime.isSameDay(nowTime)
                ? ScheduleToDoListType.TodayUncompleted
                : ScheduleToDoListType.PastUncompleted])!
            .list;
        list.add(toDoItem);
        list.sort(sortByDate);
      }
      update(toDoItem);
    });
  }

  void deleteSchedule(ScheduleToDoListType type, int index) {
    final ToDoItem toDoItem = _scheduleToDoListMap[type]!.list.removeAt(index);
    _toDoList.remove(toDoItem);
    delete(toDoItem.id);
  }

  Future<void> insert(ToDoItem item) async {
    if (item.startTime.isBefore(nowTime)) {
      final list =
          _scheduleToDoListMap[ScheduleToDoListType.PastUncompleted]!.list;
      list.add(item);
      list.sort(sortByDate);
    } else if (item.startTime.isSameDay(nowTime)) {
      final list =
          _scheduleToDoListMap[ScheduleToDoListType.TodayUncompleted]!.list;
      list.add(item);
      list.sort(sortByDate);
    }
    _toDoList.add(item);

    final db = await _db;

    await db.insert(
      'to_do_list',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<void> update(ToDoItem item) async {
    final db = await _db;

    await db.update(
      'to_do_list',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
    notifyListeners();
  }

  Future<void> delete(int id) async {
    final db = await _db;

    await db.delete(
      'to_do_list',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }
}
