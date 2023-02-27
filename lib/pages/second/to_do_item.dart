import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/dashed_line.dart';
import 'package:doit/widgets/svg.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class ToDoItemWidget extends StatelessWidget {
  const ToDoItemWidget(this.item);
  final ToDoItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MEAS.toDoListTimelineContainerWidth,
            height: 16.h,
            margin: const EdgeInsets.only(right: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Styles.GeneralBackgroundColor,
            ),
            child: Text(
              item.to != null ? getClockTime(item.to!) : '整天',
              style: TextStyle(
                color: Styles.PrimaryColor,
                fontSize: 11.sp,
                height: 16.sp / 11.sp,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: Styles.ToDoItemBackgroundColor,
              ),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MEAS.toDoItemLevelWidth,
                        height: MEAS.toDoItemLevelWidth,
                        margin: const EdgeInsets.only(
                          right: 4,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: item.levelColor,
                        ),
                        child: svg(
                          item.levelIcon,
                          width: MEAS.toDoItemLevelIconWidth,
                          height: MEAS.toDoItemLevelIconHeight,
                        ),
                      ),
                      Text(
                        item.levelText,
                        style: TextStyle(
                          color: Styles.PrimaryColor,
                          fontSize: 11.sp,
                          height: 16.sp / 11.sp,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: MEAS.toDoItemTypeWidth,
                        height: MEAS.toDoItemTypeHeight,
                        margin: const EdgeInsets.only(
                          right: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: item.typeColor,
                        ),
                        child: svg(
                          item.typeIcon,
                          width: MEAS.toDoItemTypeIconWidth,
                          height: MEAS.toDoItemTypeIconHeight,
                        ),
                      ),
                      Text(
                        item.typeText,
                        style: TextStyle(
                          color: Styles.PrimaryColor,
                          fontSize: 11.sp,
                          height: 16.sp / 11.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item.title,
                    style: TextStyle(
                      color: Styles.PrimaryColor,
                      fontSize: 14.sp,
                      height: 20.sp / 14.sp,
                    ),
                  ),
                  if (item.remarks != '') ...[
                    SizedBox(height: 2.h),
                    Text(
                      item.remarks,
                      style: TextStyle(
                        color: Styles.ToDoItemRemarksColor,
                        fontSize: 11.sp,
                        height: 16.sp / 11.sp,
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
}
