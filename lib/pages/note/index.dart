import 'package:doit/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/providers/note.dart';
import 'package:doit/constants/styles.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  List<Widget> buildWidgets(BuildContext context) {
    final List<Widget> _widgets = [];
    final focusedNote =
        Provider.of<NoteProvider>(context, listen: false).focusedNote!;
    if (focusedNote.images.length > 0) {
      _widgets.add(
        Image.memory(
          focusedNote.images[0],
          fit: BoxFit.cover,
        ),
      );
    }
    _widgets.add(
      Container(
        padding: EdgeInsets.only(
          top: 16.h,
          left: 24.w,
          right: 24.w,
          bottom: 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextBuilder(
              focusedNote.title,
              color: Styles.PrimaryTextColor,
              fontSize: Styles.noteTitleSize,
              lineHeight: Styles.noteTitleLineHeight,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 4.h),
            TextBuilder(
              getDateTime(focusedNote.publishTime),
              color: Styles.SecondaryTextColor,
              fontSize: Styles.smallTextSize,
              lineHeight: Styles.smallTextLineHeight,
            ),
            SizedBox(height: 20.h),
            TextBuilder(
              focusedNote.body,
              color: Styles.PrimaryTextColor,
              fontSize: Styles.textSize,
              lineHeight: Styles.noteTitleLineHeight,
            ),
          ],
        ),
      ),
    );

    return _widgets;
  }

  @override
  Widget build(BuildContext context) {
    final _widgets = buildWidgets(context);
    return Scaffold(
      appBar: NotesPageAppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) => _widgets[index],
        itemCount: _widgets.length,
      ),
      backgroundColor: Styles.RegularBaseColor,
    );
  }
}
