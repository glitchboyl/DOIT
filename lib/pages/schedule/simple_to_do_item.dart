import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'simple_to_do_item_operation.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class SimpleToDoItemWidget extends StatelessWidget {
  const SimpleToDoItemWidget(
    this.item, {
    required this.onCompleted,
    required this.onResumed,
    required this.onDismissed,
  });

  final ToDoItem item;
  final void Function() onCompleted;
  final void Function() onResumed;
  final void Function() onDismissed;

  @override
  Widget build(BuildContext context) => Container(
        key: item.id,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Styles.RegularBaseColor,
        ),
        margin: EdgeInsets.only(top: 10.w),
        child: Slidable(
          groupTag: 'KEEP_ONLY_ONE_SLIDABLE_OPEN',
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 12.w,
            ),
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
                        color: item.completeTime != null
                            ? Styles.DeactivedDeepColor
                            : Styles.PrimaryTextColor,
                        fontSize: Styles.textSize,
                        height: Styles.textLineHeight / Styles.textSize,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      getToDoItemTime(
                        item.startTime,
                        item.endTime,
                      ),
                      style: TextStyle(
                        color: item.completeTime != null
                            ? Styles.DeactivedDeepColor
                            : item.level == ToDoItemLevel.I
                                ? item.levelColor
                                : Styles.SecondaryTextColor,
                        fontSize: Styles.smallTextSize,
                        height:
                            Styles.smallTextLineHeight / Styles.smallTextSize,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.18,
            children: [
              SimpleToDoItemOperation(
                key: ValueKey(item.id.toString() + '_LEFT_SLIDER_ACTION'),
                icon:
                    'assets/images/${item.completeTime != null ? 'resume' : 'complete'}_to_do_item.svg',
                color: item.completeTime != null
                    ? Styles.ResumeColor
                    : Styles.CompleteColor,
                activedColor: item.completeTime != null
                    ? Styles.ResumeActivedColor
                    : Styles.CompleteActivedColor,
                onPressed: item.completeTime != null ? onResumed : onCompleted,
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.18,
            children: [
              SimpleToDoItemOperation(
                key: ValueKey(item.id.toString() + '_RIGHT_SLIDER_ACTION'),
                icon: 'assets/images/delete_to_do_item.svg',
                color: Styles.DangerousColor,
                activedColor: Styles.DangerousActivedColor,
                onPressed: onDismissed,
              ),
            ],
          ),
        ),
      );
}
