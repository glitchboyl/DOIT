import 'package:flutter/cupertino.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/styles.dart';

class ToDoItemWidget extends StatelessWidget {
  const ToDoItemWidget(this.item);
  final ToDoItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: item.remarks != '' ? 84.h : 70.h,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 4),
            child: Column(
              children: [
                Text(
                  '整天',
                  style: TextStyle(
                    color: Styles.ToDoItemTitleColor,
                    fontSize: 10.sp,
                  ),
                ),
                Expanded(
                  child: DottedLine(
                    direction: Axis.vertical,
                    dashColor: Color(0xFFDBDEEE),
                    lineThickness: 2.0,
                  ),
                ),
              ],
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
                color: CupertinoColors.white,
              ),
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.h,
                        margin: const EdgeInsets.only(
                          right: 4,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: CupertinoColors.activeOrange,
                        ),
                      ),
                      Text(
                        '重要不紧急',
                        style: TextStyle(
                          color: Styles.ToDoItemTitleColor,
                          fontSize: 10.sp,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 10.h,
                        ),
                      ),
                      Container(
                        width: 12.w,
                        height: 12.w,
                        margin: const EdgeInsets.only(
                          right: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: CupertinoColors.systemGreen,
                        ),
                      ),
                      Text(
                        '日常',
                        style: TextStyle(
                          color: Styles.ToDoItemTitleColor,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    item.title,
                    style: TextStyle(
                      color: Styles.ToDoItemTitleColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  if (item.remarks != '') ...[
                    SizedBox(height: 2.h),
                    Text(
                      item.remarks,
                      style: TextStyle(
                        color: Styles.ToDoItemRemarksColor,
                        fontSize: 10.sp,
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
