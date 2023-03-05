import 'package:flutter/widgets.dart';
import 'to_do_item.dart';

class ToDoListModel extends ChangeNotifier {
  final List<ToDoItem> _toDoList = [];

  void add(ToDoItem item) {
    _toDoList.add(item);
    notifyListeners();
  }

  void removeAll() {
    _toDoList.clear();
    notifyListeners();
  }
}