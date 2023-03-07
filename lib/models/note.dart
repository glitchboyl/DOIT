import 'dart:typed_data';

const imagesMaxLimit = 5;

class Note {
  Note({
    required this.id,
    required this.title,
    this.body = '',
    this.images = const <Uint8List>[],
    required this.publishTime,
    this.location,
  });

  final int id;
  String title;
  String body;
  List<Uint8List> images;
  DateTime publishTime;
  String? location;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'publishTime': publishTime.millisecondsSinceEpoch,
      'image_1': images.length > 0 ? images[0] : null,
      'image_2': images.length > 1 ? images[1] : null,
      'image_3': images.length > 2 ? images[2] : null,
      'image_4': images.length > 3 ? images[3] : null,
      'image_5': images.length > 4 ? images[4] : null,
    };
  }
}