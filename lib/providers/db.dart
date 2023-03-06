import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late Future<Database> _db;

final Future<void> Function(List<DBProvider> _providers) connectDB =
    (_providers) async => {
          WidgetsFlutterBinding.ensureInitialized(),
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
          ),
          _providers.forEach((provider) => provider.getData()),
        };

final Future<Database> Function() getDBHelper = () async => _db;

class DBProvider {
  void getData() {}
}
