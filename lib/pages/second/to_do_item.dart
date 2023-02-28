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
              decoration: const BoxDecoration(
                color: Styles.PageBackgroundColor,
              ),
              child: Text(
                item.to != null ? getClockTime(item.to!) : '整天',
                style: TextStyle(
                  color: Styles.TextColor,
                  fontSize: MEAS.smallTextSize,
                  height: MEAS.smallTextLineHeight / MEAS.smallTextSize,
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
                  color: Styles.ToDoItemBackgroundColor,
                ),
                padding: EdgeInsets.all(12.w),
                margin: EdgeInsets.only(bottom: 10.w),
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
                            color: Styles.TextColor,
                            fontSize: MEAS.smallTextSize,
                            height:
                                MEAS.smallTextLineHeight / MEAS.smallTextSize,
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
                            color: Styles.TextColor,
                            fontSize: MEAS.smallTextSize,
                            height:
                                MEAS.smallTextLineHeight / MEAS.smallTextSize,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      item.title,
                      style: TextStyle(
                        color: Styles.TextColor,
                        fontSize: MEAS.textSize,
                        height: MEAS.textLineHeight / MEAS.textSize,
                      ),
                    ),
                    if (item.remarks != '') ...[
                      SizedBox(height: 2.h),
                      Text(
                        item.remarks,
                        style: TextStyle(
                          color: Styles.ToDoItemRemarksColor,
                          fontSize: MEAS.smallTextSize,
                          height: MEAS.smallTextLineHeight / MEAS.smallTextSize,
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
