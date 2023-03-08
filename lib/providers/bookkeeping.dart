import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'db.dart';

class BookkeepingProvider extends ChangeNotifier {
  final List<BookkeepingItem> _bookkeepingList = [];
  final Map<DateTime, List<BookkeepingItem>> _bookkeepingMap = {};

  List<BookkeepingItem> get bookkeepingList => _bookkeepingList;
  Map<DateTime, List<BookkeepingItem>> get bookkeepingMap => _bookkeepingMap;

  Future<void> get() async {
    final maps = await DBHelper.get('bookkeeping_list');
    // _bookkeepingList.addAll(
    //   List.generate(
    //     maps.length,
    //     (i) {
    //       final item = maps[i];
    //       final List<Uint8List> _images = [];
    //       int n = 1;
    //       while (n <= imagesMaxLimit) {
    //         final Uint8List? image = item['image_${n++}'];
    //         if (image != null) {
    //           _images.add(image);
    //         } else {
    //           break;
    //         }
    //       }
    //       return BookkeepingItem(
    //         id: item['id'],
    //         title: item['title'],
    //         body: item['body'],
    //         publishTime:
    //             DateTime.fromMillisecondsSinceEpoch(item['publishTime']),
    //         images: _images,
    //         // location: item['location'],
    //       );
    //     },
    //   ).reversed.toList(),
    // );

    notifyListeners();
  }

  Future<void> insert(BookkeepingItem item) async {
    await DBHelper.insert('bookkeeping_list', item);
    // _noteList.insert(0, note);
    // focus(note);
    notifyListeners();
  }

  Future<void> update(BookkeepingItem item) async {
    await DBHelper.update('bookkeeping_list', item);
    notifyListeners();
  }

  Future<void> delete(BookkeepingItem item) async {
    _bookkeepingList.remove(item);
    await DBHelper.delete('bookkeeping_list', item.id);
    notifyListeners();
  }
}
