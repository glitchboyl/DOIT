import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'slidable_action.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

const Duration _kSilde = Duration(milliseconds: 200);

class SimpleToDoItemWidget extends StatelessWidget {
  const SimpleToDoItemWidget(
    this.item, {
    required this.onStatusChanged,
    required this.onEdited,
    required this.onDeleted,
    this.leftActionDismissible = true,
  });

  final ToDoItem item;
  final void Function(BuildContext context) onStatusChanged;
  final void Function(BuildContext context) onEdited;
  final void Function(BuildContext context) onDeleted;
  final bool leftActionDismissible;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      key: ValueKey(item.id),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colorScheme.regularBaseColor,
      ),
      margin: EdgeInsets.only(top: 10),
      child: Slidable(
        key: ValueKey(item.id.toString() + '_SLIDABLE'),
        groupTag: 'KEEP_ONLY_ONE_SLIDABLE_OPEN',
        child: Container(
          padding: EdgeInsets.only(
            top: 12,
            bottom: 12,
            right: 8,
          ),
          child: Row(
            children: [
              Container(
                width: MEAS.simpleToDoItemLevelWidth,
                height: MEAS.simpleToDoItemLevelHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(2),
                  ),
                  color: item.levelColor(context),
                ),
              ),
              Container(
                width: MEAS.simpleToDoItemTypeLength,
                height: MEAS.simpleToDoItemTypeLength,
                margin: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: item.typeColor(context),
                ),
                child: SVGIcon(
                  item.typeIcon(context),
                  width: MEAS.simpleToDoItemTypeIconLength,
                  height: MEAS.simpleToDoItemTypeIconLength,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      style: TextStyles.regularTextStyle.copyWith(
                        color: item.completeTime != null
                            ? colorScheme.deactivedDeepColor
                            : colorScheme.primaryTextColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      getToDoItemTimeText(
                        item.startTime,
                        item.endTime,
                      ),
                      style: TextStyles.smallTextStyle.copyWith(
                        color: item.completeTime != null
                            ? colorScheme.deactivedDeepColor
                            : item.level == ToDoItemLevel.I
                                ? item.levelColor(context)
                                : colorScheme.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: leftActionDismissible
              ? DismissiblePane(
                  onDismissed: () => onStatusChanged(context),
                )
              : null,
          extentRatio: leftActionDismissible ? 0.5 : 0.18,
          children: [
            SlidableActionBuilder(
              key: ValueKey(item.id.toString() + '_CHANGE_STATUS'),
              color: item.completeTime != null
                  ? colorScheme.resumeColor
                  : colorScheme.completeColor,
              onPressed: (ctx) => leftActionDismissible
                  ? Slidable.of(ctx)?.dismiss(
                      ResizeRequest(
                        _kSilde,
                        () => onStatusChanged(context),
                      ),
                      duration: _kSilde,
                    )
                  : onStatusChanged(context),
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
              autoClose: !leftActionDismissible,
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
              onPressed: (context) => onEdited(context),
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
              onPressed: (context) => onDeleted(context),
              autoClose: true,
            ),
          ],
        ),
      ),
    );
  }
}
