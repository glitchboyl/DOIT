import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late Future<Database> _db;

final Future<void> Function() connectDB = () async => {
      print(await getDatabasesPath()),
      _db = openDatabase(
        join(await getDatabasesPath(), 'doit_database.db'),
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE to_do_list(id INTEGER PRIMARY KEY, title TEXT NOT NULL, remarks TEXT, type INTEGER NOT NULL, level INTEGER NOT NULL, startTime INTEGER NOT NULL, endTime INTEGER NOT NULL, repeatType INTEGER NOT NULL, notificationType INTEGER NOT NULL, completeTime INTEGER)',
          );
          await db.execute(
            'CREATE TABLE note_list(id INTEGER PRIMARY KEY, title TEXT NOT NULL, body TEXT, publishTime INTEGER NOT NULL, image_1 BLOB, image_2 BLOB, image_3 BLOB, image_4 BLOB, image_5 BLOB)',
          );
          await db.execute(
            'CREATE TABLE bookkeeping_list(id INTEGER PRIMARY KEY, title TEXT NOT NULL, amount TEXT NOT NULL, time INTEGER NOT NULL, type INTEGER NOT NULL, category INTEGER NOT NULL)',
          );
        },
        version: 1,
      ),
    };

final Future<Database> Function() getDB = () async => _db;

abstract class DBHelper {
  static Future<List<Map<String, dynamic>>> get(String table) async {
    final db = await getDB();
    return await db.query(table);
  }

  static Future<void> insert(String table, dynamic data) async {
    final db = await getDB();
    await db.insert(
      table,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(String table, dynamic data) async {
    final db = await getDB();

    await db.update(
      table,
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  static Future<void> delete(String table, int id) async {
    final db = await getDB();

    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
