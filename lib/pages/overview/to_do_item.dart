import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/icon.dart';
import 'package:doit/widgets/slidable_action.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class ToDoItemWidget extends StatelessWidget {
  const ToDoItemWidget(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MEAS.toDoListTimelineContainerWidth + 2,
              height: Styles.smallTextLineHeight,
              margin: EdgeInsets.only(right: 2),
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
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: Styles.RegularBaseColor,
                ),
                margin: EdgeInsets.only(bottom: 10),
                clipBehavior: Clip.antiAlias,
                child: Slidable(
                  key: ValueKey(item.id.toString() + '_SLIDABLE'),
                  groupTag: 'KEEP_ONLY_ONE_SLIDABLE_OPEN',
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconBuilder(
                              item.levelIcon,
                              width: MEAS.toDoItemLevelLength,
                              height: MEAS.toDoItemLevelLength,
                              margin: EdgeInsets.only(
                                right: 4,
                              ),
                              borderRadius: BorderRadius.circular(50),
                              color: item.levelColor,
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
                              item.typeIcon,
                              width: MEAS.toDoItemTypeLength,
                              height: MEAS.toDoItemTypeLength,
                              margin: EdgeInsets.only(
                                right: 4,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              color: item.typeColor,
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
                        SizedBox(height: 8),
                        TextBuilder(
                          item.title,
                          color: Styles.PrimaryTextColor,
                          fontSize: Styles.textSize,
                          lineHeight: Styles.textLineHeight,
                        ),
                        if (item.remarks != '') ...[
                          SizedBox(height: 2),
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
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.18,
                    children: [
                      SlidableActionBuilder(
                        key: ValueKey(item.id.toString() + '_CHANGE_STATUS'),
                        color: item.completeTime != null
                            ? Styles.ResumeColor
                            : Styles.CompleteColor,
                        onPressed: onStatusChanged,
                        child: Container(
                          height: double.infinity,
                          padding: EdgeInsets.only(
                            right: 16,
                          ),
                          alignment: Alignment.centerRight,
                          child: SVGIcon(
                            'assets/images/${item.completeTime != null ? 'resume' : 'complete'}_to_do_item.svg',
                            width: MEAS.itemOperationIconLength,
                            height: MEAS.itemOperationIconLength,
                          ),
                        ),
                        autoClose: true,
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.36,
                    children: [
                      SlidableActionBuilder(
                        key: ValueKey(item.id.toString() + '_EDIT'),
                        color: Styles.PrimaryColor,
                        child: SVGIcon(
                          'assets/images/edit.svg',
                          color: Styles.RegularBaseColor,
                          width: MEAS.itemOperationIconLength,
                          height: MEAS.itemOperationIconLength,
                        ),
                        onPressed: onEdited,
                        autoClose: true,
                      ),
                      SlidableActionBuilder(
                        key: ValueKey(item.id.toString() + '_DELETE'),
                        color: Styles.DangerousColor,
                        child: SVGIcon(
                          'assets/images/trash.svg',
                          color: Styles.RegularBaseColor,
                          width: MEAS.itemOperationIconLength,
                          height: MEAS.itemOperationIconLength,
                        ),
                        onPressed: onDeleted,
                        autoClose: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
