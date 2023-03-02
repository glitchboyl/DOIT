import 'package:flutter/material.dart';

class NoteItem {
  NoteItem({
    required this.id,
    required this.title,
    required this.body,
    required this.publishTime,
    this.location,
  });

  final Key id;
  String title;
  String body;
  DateTime publishTime;
  String? location;
}
