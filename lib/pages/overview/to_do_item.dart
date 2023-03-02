import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class ToDoItemWidget extends StatelessWidget {
  const ToDoItemWidget(this.item);
  final ToDoItem item;

  @override
  Widget build(BuildContext context) => Container(
        key: item.id,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MEAS.toDoListTimelineContainerWidth,
              height: 16.h,
              margin: EdgeInsets.only(right: 2.w),
              alignment: Alignment.center,
              color: Styles.BackgroundColor,
              child: Text(
                // item.startTime != null ? getClockTime(item.startTime!) : '整天',
                getClockTime(item.startTime),
                style: TextStyle(
                  color: Styles.PrimaryTextColor,
                  fontSize: Styles.smallTextSize,
                  height: Styles.smallTextLineHeight / Styles.smallTextSize,
                ),
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
                        Container(
                          width: MEAS.toDoItemLevelWidth,
                          height: MEAS.toDoItemLevelWidth,
                          margin: EdgeInsets.only(
                            right: 4.w,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: item.levelColor,
                          ),
                          child: SVGIcon(
                            icon: item.levelIcon,
                            width: MEAS.toDoItemLevelIconWidth,
                            height: MEAS.toDoItemLevelIconHeight,
                          ),
                        ),
                        Text(
                          item.levelText,
                          style: TextStyle(
                            color: Styles.PrimaryTextColor,
                            fontSize: Styles.smallTextSize,
                            height:
                                Styles.smallTextLineHeight / Styles.smallTextSize,
                          ),
                        ),
                        Expanded(
                          child: SizedBox.shrink(),
                        ),
                        Container(
                          width: MEAS.toDoItemTypeWidth,
                          height: MEAS.toDoItemTypeHeight,
                          margin: EdgeInsets.only(
                            right: 4.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: item.typeColor,
                          ),
                          child: SVGIcon(
                            icon: item.typeIcon,
                            width: MEAS.toDoItemTypeIconWidth,
                            height: MEAS.toDoItemTypeIconHeight,
                          ),
                        ),
                        Text(
                          item.typeText,
                          style: TextStyle(
                            color: Styles.PrimaryTextColor,
                            fontSize: Styles.smallTextSize,
                            height:
                                Styles.smallTextLineHeight / Styles.smallTextSize,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      item.title,
                      style: TextStyle(
                        color: Styles.PrimaryTextColor,
                        fontSize: Styles.textSize,
                        height: Styles.textLineHeight / Styles.textSize,
                      ),
                    ),
                    if (item.remarks != '') ...[
                      SizedBox(height: 2.h),
                      Text(
                        item.remarks,
                        style: TextStyle(
                          color: Styles.SecondaryTextColor,
                          fontSize: Styles.smallTextSize,
                          height: Styles.smallTextLineHeight / Styles.smallTextSize,
                        ),
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
