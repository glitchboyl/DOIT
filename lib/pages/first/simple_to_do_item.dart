import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class SimpleToDoItemWidget extends StatelessWidget {
  const SimpleToDoItemWidget(this.item);

  final ToDoItem item;

  @override
  Widget build(BuildContext context) => Container(
        key: item.id,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Styles.ToDoItemBackgroundColor,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12.w,
        ),
        margin: EdgeInsets.only(top: 10.w),
        child: Row(
          children: [
            Container(
              width: MEAS.simpleToDoItemLevelWidth,
              height: MEAS.simpleToDoItemLevelHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(2.r),
                ),
                color: item.levelColor,
              ),
            ),
            Container(
              width: MEAS.simpleToDoItemTypeWidth,
              height: MEAS.simpleToDoItemTypeHeight,
              margin: EdgeInsets.symmetric(
                horizontal: 12.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: item.typeColor,
              ),
              child: SVGIcon(
                icon: item.typeIcon,
                width: MEAS.simpleToDoItemTypeIconWidth,
                height: MEAS.simpleToDoItemTypeIconHeight,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    color: Styles.TextColor,
                    fontSize: MEAS.textSize,
                    height: MEAS.textLineHeight / MEAS.textSize,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  getToDoItemTime(to: item.to, from: item.from),
                  style: TextStyle(
                    color: item.level == ToDoItemLevel.IV
                        ? item.levelColor
                        : Styles.ToDoItemTimeColor,
                    fontSize: MEAS.smallTextSize,
                    height: MEAS.smallTextLineHeight / MEAS.smallTextSize,
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
