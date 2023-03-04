import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/note_item.dart';
import 'package:doit/widgets/text.dart';
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
            TextBuilder(
              item.title,
              color: Styles.PrimaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: Styles.textSize,
              lineHeight: Styles.textLineHeight,
            ),
            SizedBox(height: 2.h),
            TextBuilder(
              getNoteTime(item.publishTime),
              color: Styles.SecondaryTextColor,
              fontSize: Styles.smallTextSize,
              lineHeight: Styles.smallTextLineHeight,
            ),
            SizedBox(height: 12.h),
            SVGIcon(
              icon: 'assets/images/opening_quotes.svg',
              width: MEAS.noteItemQuotesWidth,
              height: MEAS.noteItemQuotesHeight,
            ),
            if (item.images!.length > 0)
              Container(
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  item.images![0],
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 10.h),
            TextBuilder(
              item.body,
              color: Styles.PrimaryTextColor,
              fontSize: Styles.smallTextSize,
              lineHeight: Styles.smallTextLineHeight,
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
