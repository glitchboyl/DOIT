import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'db.dart';
import 'package:doit/models/note.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> _noteList = [];
  Note? _focusedNote;

  List<Note> get noteList => _noteList;
  Note? get focusedNote => _focusedNote;
  void focus(Note? note) => _focusedNote = note;

  Future<void> get() async {
    final maps = await DBHelper.get('note_list');
    _noteList.addAll(
      List.generate(
        maps.length,
        (i) {
          final item = maps[i];
          final List<Uint8List> _images = [];
          int n = 1;
          while (n <= imagesMaxLimit) {
            final Uint8List? image = item['image_${n++}'];
            if (image != null) {
              _images.add(image);
            } else {
              break;
            }
          }
          return Note(
            id: item['id'],
            title: item['title'],
            body: item['body'],
            publishTime:
                DateTime.fromMillisecondsSinceEpoch(item['publishTime']),
            images: _images,
            // location: item['location'],
          );
        },
      ),
    );
    _noteList.sort(sortByPublishTime);

    notifyListeners();
  }

  Future<void> insert(Note note) async {
    await DBHelper.insert('note_list', note);
    _noteList.insert(0, note);
    focus(note);
    notifyListeners();
  }

  Future<void> update(Note note) async {
    await DBHelper.update('note_list', note);
    notifyListeners();
  }

  Future<void> delete(Note note) async {
    _noteList.remove(note);
    await DBHelper.delete('note_list', note.id);
    notifyListeners();
  }
}
