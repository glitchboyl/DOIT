import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/icon.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/slidable_action.dart';
import 'package:doit/utils/money_format.dart';
import 'package:doit/utils/time.dart';
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
  Widget build(BuildContext context) => Container(
        key: ValueKey(item.id),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Styles.RegularBaseColor,
        ),
        clipBehavior: Clip.antiAlias,
        child: Slidable(
          key: ValueKey(item.id.toString() + '_SLIDABLE'),
          groupTag: 'KEEP_ONLY_ONE_SLIDABLE_OPEN',
          child: Container(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                IconBuilder(
                  BookkeepingItemCategoryMap[item.category]!.icon,
                  width: MEAS.bookkeepingItemTypeLength,
                  height: MEAS.bookkeepingItemTypeLength,
                  margin: EdgeInsets.only(
                    right: 8,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Styles.BackgroundColor,
                  iconWidth: MEAS.bookkeepingItemTypeIconLength,
                  iconHeight: MEAS.bookkeepingItemTypeIconLength,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBuilder(
                      item.title,
                      color: Styles.PrimaryTextColor,
                      fontSize: Styles.textSize,
                      lineHeight: Styles.textLineHeight,
                    ),
                    TextBuilder(
                      getClockTime(item.time),
                      color: Styles.SecondaryTextColor,
                      fontSize: Styles.smallTextSize,
                      lineHeight: Styles.smallTextLineHeight,
                    ),
                  ],
                ),
                Spacer(),
                TextBuilder(
                  '${item.type == BookkeepingItemType.Incomes ? '+' : '-'}${moneyFormat(item.amount)}',
                  color: item.type == BookkeepingItemType.Incomes
                      ? Styles.PrimaryColor
                      : Styles.DangerousColor,
                  fontWeight: FontWeight.bold,
                  fontSize: Styles.textSize,
                  lineHeight: Styles.textLineHeight,
                ),
              ],
            ),
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
