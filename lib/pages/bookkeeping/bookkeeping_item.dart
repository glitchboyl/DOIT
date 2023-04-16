import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/widgets/bookkeeping_data_row.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/slidable_action.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingItemWidget extends StatelessWidget {
  const BookkeepingItemWidget(
    this.item, {
    required this.onEdited,
    required this.onDeleted,
  });

  final BookkeepingItem item;
  final void Function(BuildContext context) onEdited;
  final void Function(BuildContext context) onDeleted;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      key: ValueKey(item.id),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colorScheme.regularBaseColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: Slidable(
        key: ValueKey(item.id.toString() + '_SLIDABLE'),
        groupTag: 'KEEP_ONLY_ONE_SLIDABLE_OPEN',
        child: BookkeepingDataRow(
          icon: bookkeepingItemCategoryMap[item.category]!.icon(context),
          title: item.title,
          subTitle: getClockTime(item.time),
          amount: item.amount,
          type: item.type,
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
                width: MEAS.itemOperationIconLength,
                height: MEAS.itemOperationIconLength,
                color: colorScheme.whiteColor,
              ),
              onPressed: (context) => onEdited(context),
              autoClose: true,
            ),
            SlidableActionBuilder(
              key: ValueKey(item.id.toString() + '_DELETE'),
              color: colorScheme.dangerousColor,
              child: SVGIcon(
                Ico.Trash,
                width: MEAS.itemOperationIconLength,
                height: MEAS.itemOperationIconLength,
                color: colorScheme.whiteColor,
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
