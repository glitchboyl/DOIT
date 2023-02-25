enum ToDoItemStatus { a, b, c, d }

enum ToDoItemType { a, b, c, d }

class ToDoItem {
  const ToDoItem({
    required this.id,
    required this.title,
    this.remarks = '',
    this.type = ToDoItemType.a,
    this.status = ToDoItemStatus.a,
    this.to,
    this.from,
  });

  final int id;
  final String title;
  final String remarks;
  final ToDoItemType type;
  final ToDoItemStatus status;
  final DateTime? to;
  final DateTime? from;
}
