import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'note_item.dart';
import 'package:doit/models/note_item.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  _NotesPageState createState() => _NotesPageState();

  static final appBar = ({Key? key}) => NotesPageAppBar(key: key);
}

class _NotesPageState extends State<NotesPage> {
  List<NoteItem> mockList = [
    NoteItem(
      id: UniqueKey(),
      title: '芜湖',
      body: '什么玩意',
      images: ['assets/images/test_1.jpeg'],
      publishTime: DateTime(2023, 2, 26),
    ),
    NoteItem(
      id: UniqueKey(),
      title: 'The Pursuit of Happyness',
      body:
          'I’m the type of person, if you ask me a question, and I don’t know the answer, I’m gonna to tell you that I don’t know. ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo',
      images: ['assets/images/test_2.jpeg'],
      publishTime: DateTime(2022, 1, 25),
    ),
  ];

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: 14.h,
          left: 16.w,
          right: 16.w,
        ),
        child: CustomScrollView(
          slivers: [
            SliverSafeArea(
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => NoteItemWidget(
                    mockList[index],
                  ),
                  childCount: mockList.length,
                ),
              ),
            ),
          ],
        ),
      );
}
