import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:doit/models/to_do_item.dart';
class TodoListProvider {
  late Future<Database> provider;

  void connect() async {
    WidgetsFlutterBinding.ensureInitialized();
    provider = openDatabase(
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
  }

  Future<List<ToDoItem>> get() async {
    final db = await provider;

    final List<Map<String, dynamic>> maps = await db.query('to_do_list');

    return List.generate(maps.length, (i) {
      final item = maps[i];
      return ToDoItem(
        id: item['id'],
        title: item['title'],
        remarks: item['remarks'],
        type: ToDoItemType.values[item['type']],
        level: ToDoItemLevel.values[item['level']],
        startTime: DateTime(item['startTime']),
        endTime: DateTime(item['endTime']),
        repeatType: RepeatType.values[item['repeatType']],
        completeTime: item['completeTime'] != null ? DateTime(item['completeTime']) : null,
      );
    });
  }

  Future<void> insert(ToDoItem item) async {
    final db = await provider;

    await db.insert(
      'to_do_list',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(ToDoItem item) async {
    final db = await provider;

    await db.update(
      'to_do_list',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteDog(int id) async {
    final db = await provider;

    await db.delete(
      'to_do_list',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}