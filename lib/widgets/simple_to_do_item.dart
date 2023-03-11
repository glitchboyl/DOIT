import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'slidable_action.dart';
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
    this.leftActionDismissible = true,
  });

  final ToDoItem item;
  final void Function(BuildContext context) onStatusChanged;
  final void Function(BuildContext context) onEdited;
  final void Function(BuildContext context) onDeleted;
  final bool leftActionDismissible;

  @override
  Widget build(BuildContext context) => Container(
        key: ValueKey(item.id),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Styles.RegularBaseColor,
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
                    color: item.levelColor,
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
                      SizedBox(height: 2),
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
                    ? Styles.ResumeColor
                    : Styles.CompleteColor,
                onPressed: (context) {
                  leftActionDismissible
                      ? Slidable.of(context)?.dismiss(
                          ResizeRequest(
                            _kSilde,
                            () => onStatusChanged(context),
                          ),
                          duration: _kSilde,
                        )
                      : onStatusChanged(context);
                },
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
                onPressed: (context) => onEdited(context),
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
                onPressed: (context) => onDeleted(context),
                autoClose: true,
              ),
            ],
          ),
        ),
      );
}
