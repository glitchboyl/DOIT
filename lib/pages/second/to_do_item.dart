import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/dashed_line.dart';
import 'package:doit/widgets/svg.dart';
import 'package:doit/constants/colors.dart';
import 'package:doit/constants/meas.dart';

class ToDoItemWidget extends StatelessWidget {
  const ToDoItemWidget(this.item);
  final ToDoItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: item.remarks != '' ? 94.h : 78.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28.w,
            height: 14.h,
            margin: const EdgeInsets.only(right: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.GeneralBackgroundColor,
            ),
            child: Text(
              item.to != null ? getClockTime(item.to!) : '整天',
              style: TextStyle(
                color: Colors.ToDoItemTitleColor,
                fontSize: 10.sp,
                height: 14.sp / 10.sp,
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
                          color: Colors.ToDoItemTitleColor,
                          fontSize: 10.sp,
                          height: 14.sp / 10.sp,
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
                        //   ConstrainedBox(
                        //       constraints: BoxConstraints(
                        //         maxWidth: MEAS.toDoItemTypeIconWidth,
                        //         maxHeight: MEAS.toDoItemTypeIconHeight,
                        //       ),
                        //       child: Container(
                        //         color: CupertinoColors.activeOrange,
                        //       )

                        //       ),
                      ),
                      Text(
                        '日常',
                        style: TextStyle(
                          color: Colors.ToDoItemTitleColor,
                          fontSize: 10.sp,
                          height: 14.sp / 10.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    item.title,
                    style: TextStyle(
                      color: Colors.ToDoItemTitleColor,
                      fontSize: 14.sp,
                      height: 20.sp / 14.sp,
                    ),
                  ),
                  if (item.remarks != '') ...[
                    SizedBox(height: 2.h),
                    Text(
                      item.remarks,
                      style: TextStyle(
                        color: Colors.ToDoItemRemarksColor,
                        fontSize: 10.sp,
                        height: 14.sp / 10.sp,
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
