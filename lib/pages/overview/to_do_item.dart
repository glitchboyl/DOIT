import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:doit/widgets/icon.dart';
import 'package:doit/widgets/slidable_action.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/icons.dart';
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
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = TextStyles.smallTextStyle.copyWith(
      color: colorScheme.primaryTextColor,
    );
    return Container(
      key: ValueKey(item.id),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 7 - 14,
            // height: Styles.SmallTextLineHeight,
            margin: EdgeInsets.only(right: 2),
            alignment: Alignment.center,
            color: colorScheme.backgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!item.startTime.isSameDay(item.endTime))
                  Text(
                    getDateTime(item.startTime),
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                Text(
                  // item.startTime != null ? getClockTime(item.startTime!) : '整天',
                  getClockTime(item.startTime),
                  style: textStyle,
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
                color: colorScheme.regularBaseColor,
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
                            item.levelIcon(context),
                            width: MEAS.toDoItemLevelLength,
                            height: MEAS.toDoItemLevelLength,
                            margin: EdgeInsets.only(
                              right: 4,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            color: item.levelColor(context),
                            iconWidth: MEAS.toDoItemLevelIconLength,
                            iconHeight: MEAS.toDoItemLevelIconLength,
                          ),
                          Text(
                            item.levelText,
                            style: textStyle,
                          ),
                          Spacer(),
                          IconBuilder(
                            item.typeIcon(context),
                            width: MEAS.toDoItemTypeLength,
                            height: MEAS.toDoItemTypeLength,
                            margin: EdgeInsets.only(
                              right: 4,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            color: item.typeColor(context),
                            iconWidth: MEAS.toDoItemTypeIconLength,
                            iconHeight: MEAS.toDoItemTypeIconLength,
                          ),
                          Text(
                            item.typeText,
                            style: textStyle,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        item.title,
                        style: TextStyles.regularTextStyle.copyWith(
                          color: colorScheme.primaryTextColor,
                        ),
                      ),
                      if (item.remarks != '') ...[
                        SizedBox(height: 2),
                        Text(
                          item.remarks,
                          style: TextStyles.smallTextStyle.copyWith(
                            color: colorScheme.secondaryTextColor,
                          ),
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
                          ? colorScheme.resumeColor
                          : colorScheme.completeColor,
                      onPressed: onStatusChanged,
                      child: Container(
                        height: double.infinity,
                        padding: EdgeInsets.only(
                          right: 16,
                        ),
                        alignment: Alignment.centerRight,
                        child: SVGIcon(
                          item.completeTime != null ? Ico.Resume : Ico.Complete,
                          width: MEAS.itemOperationIconLength,
                          height: MEAS.itemOperationIconLength,
                          color: colorScheme.whiteColor,
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
                      color: colorScheme.primaryColor,
                      child: SVGIcon(
                        Ico.Edit,
                        color: colorScheme.whiteColor,
                        width: MEAS.itemOperationIconLength,
                        height: MEAS.itemOperationIconLength,
                      ),
                      onPressed: onEdited,
                      autoClose: true,
                    ),
                    SlidableActionBuilder(
                      key: ValueKey(item.id.toString() + '_DELETE'),
                      color: colorScheme.dangerousColor,
                      child: SVGIcon(
                        Ico.Trash,
                        color: colorScheme.whiteColor,
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
}
