import 'package:flutter/material.dart';

class NoteItem {
  NoteItem({
    required this.id,
    required this.title,
    required this.body,
    this.images = const <String>[],
    required this.publishTime,
    this.location,
  });

  final Key id;
  String title;
  String body;
  List<String>? images;
  DateTime publishTime;
  String? location;
}
