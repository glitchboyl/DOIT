import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'simple_to_do_item_action.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

const Duration _kSilde = Duration(milliseconds: 200);

class SimpleToDoItemWidget extends StatelessWidget {
  const SimpleToDoItemWidget(
    this.item, {
    required this.onStatusChanged,
    required this.onEdited,
    required this.onDeleted,
  });

  final ToDoItem item;
  final void Function(BuildContext context) onStatusChanged;
  final void Function(BuildContext context) onEdited;
  final void Function(BuildContext context) onDeleted;

  @override
  Widget build(BuildContext context) => Container(
        key: ValueKey(item.id),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Styles.RegularBaseColor,
        ),
        margin: EdgeInsets.only(top: 10.w),
        child: Slidable(
          key: ValueKey(item.id.toString() + '_SLIDABLE'),
          groupTag: 'KEEP_ONLY_ONE_SLIDABLE_OPEN',
          child: Container(
            padding: EdgeInsets.only(
              top: 12.h,
              bottom: 12.h,
              right: 8.w,
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
                  width: MEAS.simpleToDoItemTypeLength,
                  height: MEAS.simpleToDoItemTypeLength,
                  margin: EdgeInsets.symmetric(
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: item.typeColor,
                  ),
                  child: SVGIcon(
                    item.typeIcon,
                    width: MEAS.simpleToDoItemTypeIconLength,
                    height: MEAS.simpleToDoItemTypeIconLength,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBuilder(
                        item.title,
                        color: item.completeTime != null
                            ? Styles.DeactivedDeepColor
                            : Styles.PrimaryTextColor,
                        fontSize: Styles.textSize,
                        lineHeight: Styles.textLineHeight,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      TextBuilder(
                        getToDoItemTimeText(
                          item.startTime,
                          item.endTime,
                        ),
                        color: item.completeTime != null
                            ? Styles.DeactivedDeepColor
                            : item.level == ToDoItemLevel.I
                                ? item.levelColor
                                : Styles.SecondaryTextColor,
                        fontSize: Styles.smallTextSize,
                        lineHeight: Styles.smallTextLineHeight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(
              onDismissed: () => onStatusChanged(context),
            ),
            extentRatio: 0.5,
            children: [
              SimpleToDoItemAction(
                key: ValueKey(item.id.toString() + '_CHANGE_STATUS'),
                color: item.completeTime != null
                    ? Styles.ResumeColor
                    : Styles.CompleteColor,
                onPressed: (context) {
                  Slidable.of(context)?.dismiss(
                    ResizeRequest(
                      _kSilde,
                      () => onStatusChanged(context),
                    ),
                    duration: _kSilde,
                  );
                },
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.only(
                    right: 16.w,
                  ),
                  alignment: Alignment.centerRight,
                  child: SVGIcon(
                    'assets/images/${item.completeTime != null ? 'resume' : 'complete'}_to_do_item.svg',
                    width: MEAS.itemOperationIconLength,
                    height: MEAS.itemOperationIconLength,
                  ),
                ),
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.36,
            children: [
              SimpleToDoItemAction(
                key: ValueKey(item.id.toString() + '_EDIT'),
                color: Styles.PrimaryColor,
                child: SVGIcon(
                  'assets/images/edit.svg',
                  color: Styles.RegularBaseColor,
                  width: MEAS.itemOperationIconLength,
                  height: MEAS.itemOperationIconLength,
                ),
                onPressed: (context) => onEdited(context),
                autoClose: true,
              ),
              SimpleToDoItemAction(
                key: ValueKey(item.id.toString() + '_DELETE'),
                color: Styles.DangerousColor,
                child: SVGIcon(
                  'assets/images/trash.svg',
                  color: Styles.RegularBaseColor,
                  width: MEAS.itemOperationIconLength,
                  height: MEAS.itemOperationIconLength,
                ),
                onPressed: (context) => onDeleted(context),
                autoClose: true,
              ),
            ],
          ),
        ),
      );
}
