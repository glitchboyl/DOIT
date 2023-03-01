import 'to_do_item.dart';

class ToDoList {
  const ToDoList({
    required this.title,
    required this.list,
  });

  final String title;
  final List<ToDoItem> list;
}
