import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/note.dart';
import 'package:doit/providers/note.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class NoteItemWidget extends StatelessWidget {
  const NoteItemWidget(this.note);
  final Note note;

  List<Widget> buildWidgets() {
    final List<Widget> _widgets = [
      TextBuilder(
        note.title,
        color: Styles.PrimaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: Styles.textSize,
        lineHeight: Styles.textLineHeight,
      ),
      SizedBox(height: 2.h),
      TextBuilder(
        getNoteTime(note.publishTime),
        color: Styles.SecondaryTextColor,
        fontSize: Styles.smallTextSize,
        lineHeight: Styles.smallTextLineHeight,
      ),
    ];
    if (note.images.length > 0 || note.body.trim() != '') {
      _widgets.add(
        SizedBox(height: 12.h),
      );
      _widgets.add(
        SVGIcon(
          'assets/images/opening_quotes.svg',
          width: MEAS.noteItemQuotesLength,
          height: MEAS.noteItemQuotesLength,
        ),
      );
      if (note.images.length > 0) {
        _widgets.add(
          Container(
            margin: EdgeInsets.only(top: 10.h),
            constraints: BoxConstraints(
              minWidth: 319.w,
              minHeight: 180.h,
              maxHeight: 399.h,
            ),
            decoration: BoxDecoration(
              color: Styles.BackgroundColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.memory(
              note.images[0],
              fit: BoxFit.cover,
            ),
          ),
        );
      }
      _widgets.add(
        SizedBox(height: 10.h),
      );
      if (note.body.trim() != '') {
        _widgets.add(
          TextBuilder(
            note.body,
            color: Styles.PrimaryTextColor,
            fontSize: Styles.smallTextSize,
            lineHeight: Styles.smallTextLineHeight,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
        _widgets.add(
          SizedBox(height: 10.h),
        );
      }
      _widgets.add(
        Align(
          alignment: Alignment.centerRight,
          child: SVGIcon(
            'assets/images/closing_quotes.svg',
            width: MEAS.noteItemQuotesLength,
            height: MEAS.noteItemQuotesLength,
          ),
        ),
      );
    }

    return _widgets;
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          key: ValueKey(note.id),
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Styles.RegularBaseColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildWidgets(),
          ),
        ),
        onTap: () => {
          Provider.of<NoteProvider>(context, listen: false).focus(note),
          Navigator.pushNamed(context, '/note'),
        },
      );
}
