import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/icon.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class ToDoItemWidget extends StatelessWidget {
  const ToDoItemWidget(this.item);
  final ToDoItem item;

  @override
  Widget build(BuildContext context) => Container(
        key: ValueKey(item.id),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MEAS.toDoListTimelineContainerWidth,
              height: Styles.smallTextLineHeight,
              margin: EdgeInsets.only(right: 2.w),
              alignment: Alignment.center,
              color: Styles.BackgroundColor,
              child: TextBuilder(
                // item.startTime != null ? getClockTime(item.startTime!) : '整天',
                getClockTime(item.startTime),
                color: Styles.PrimaryTextColor,
                fontSize: Styles.smallTextSize,
                lineHeight: Styles.smallTextLineHeight,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                  color: Styles.RegularBaseColor,
                ),
                padding: EdgeInsets.all(12.w),
                margin: EdgeInsets.only(bottom: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconBuilder(
                          width: MEAS.toDoItemLevelLength,
                          height: MEAS.toDoItemLevelLength,
                          margin: EdgeInsets.only(
                            right: 4.w,
                          ),
                          borderRadius: BorderRadius.circular(50.r),
                          color: item.levelColor,
                          icon: item.levelIcon,
                          iconWidth: MEAS.toDoItemLevelIconLength,
                          iconHeight: MEAS.toDoItemLevelIconLength,
                        ),
                        TextBuilder(
                          item.levelText,
                          color: Styles.PrimaryTextColor,
                          fontSize: Styles.smallTextSize,
                          lineHeight: Styles.smallTextLineHeight,
                        ),
                        Spacer(),
                        IconBuilder(
                          width: MEAS.toDoItemTypeLength,
                          height: MEAS.toDoItemTypeLength,
                          margin: EdgeInsets.only(
                            right: 4.w,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                          color: item.typeColor,
                          icon: item.typeIcon,
                          iconWidth: MEAS.toDoItemTypeIconLength,
                          iconHeight: MEAS.toDoItemTypeIconLength,
                        ),
                        TextBuilder(
                          item.typeText,
                          color: Styles.PrimaryTextColor,
                          fontSize: Styles.smallTextSize,
                          lineHeight: Styles.smallTextLineHeight,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    TextBuilder(
                      item.title,
                      color: Styles.PrimaryTextColor,
                      fontSize: Styles.textSize,
                      lineHeight: Styles.textLineHeight,
                    ),
                    if (item.remarks != '') ...[
                      SizedBox(height: 2.h),
                      TextBuilder(
                        item.remarks,
                        color: Styles.SecondaryTextColor,
                        fontSize: Styles.smallTextSize,
                        lineHeight: Styles.smallTextLineHeight,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
