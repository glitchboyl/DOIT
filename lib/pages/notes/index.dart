import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'note_item.dart';
import 'package:doit/models/note_item.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);
  @override
  NotesPageState createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  List<NoteItem> mockList = [
    NoteItem(
      id: UniqueKey(),
      title: '芜湖',
      body: '什么玩意',
      publishTime: DateTime(2023, 2, 26),
    ),
    NoteItem(
      id: UniqueKey(),
      title: 'The Pursuit of Happyness',
      body:
          'I’m the type of person, if you ask me a question, and I don’t know the answer, I’m gonna to tell you that I don’t know. ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo',
      publishTime: DateTime(2022, 1, 25),
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarBuilder(
          title: Text(
            '日记',
            style: TextStyle(
              color: Styles.PrimaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: Styles.largeTextSize,
              height: Styles.largeTextLineHeight / Styles.largeTextSize,
            ),
          ),
        ),
        body: Padding(
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
        ),
        resizeToAvoidBottomInset: false,
      );
}
