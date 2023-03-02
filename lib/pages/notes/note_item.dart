import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/note_item.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class NoteItemWidget extends StatelessWidget {
  const NoteItemWidget(this.item);
  final NoteItem item;

  @override
  Widget build(BuildContext context) => Container(
        key: item.id,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Styles.RegularBaseColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: TextStyle(
                color: Styles.PrimaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: Styles.textSize,
                height: Styles.textLineHeight / Styles.textSize,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              getNoteTime(item.publishTime),
              style: TextStyle(
                color: Styles.SecondaryTextColor,
                fontSize: Styles.smallTextSize,
                height: Styles.smallTextLineHeight / Styles.smallTextSize,
              ),
            ),
            SizedBox(height: 12.h),
            SVGIcon(
              icon: 'assets/images/opening_quotes.svg',
              width: MEAS.noteItemQuotesWidth,
              height: MEAS.noteItemQuotesHeight,
            ),
            SizedBox(height: 10.h),
            Text(
              item.body,
              style: TextStyle(
                color: Styles.PrimaryTextColor,
                fontSize: Styles.smallTextSize,
                height: Styles.smallTextLineHeight / Styles.smallTextSize,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: SVGIcon(
                icon: 'assets/images/closing_quotes.svg',
                width: MEAS.noteItemQuotesWidth,
                height: MEAS.noteItemQuotesHeight,
              ),
            ),
          ],
        ),
      );
}
