import 'package:flutter/widgets.dart';
import 'package:doit/widgets/icon.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/utils/money_format.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingDataRow extends StatelessWidget {
  const BookkeepingDataRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.type,
    required this.amount,
    this.padding,
  });

  final String icon;
  final String title;
  final String subTitle;
  final BookkeepingItemType type;
  final double amount;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding ?? EdgeInsets.all(12),
        child: Row(
          children: [
            IconBuilder(
              icon,
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
                  title,
                  color: Styles.PrimaryTextColor,
                  fontSize: Styles.textSize,
                  lineHeight: Styles.textLineHeight,
                ),
                TextBuilder(
                  subTitle,
                  color: Styles.SecondaryTextColor,
                  fontSize: Styles.smallTextSize,
                  lineHeight: Styles.smallTextLineHeight,
                ),
              ],
            ),
            Spacer(),
            TextBuilder(
              '${type == BookkeepingItemType.Incomes ? '+' : '-'}${moneyFormat(amount)}',
              color: type == BookkeepingItemType.Incomes
                  ? Styles.PrimaryColor
                  : Styles.DangerousColor,
              fontWeight: FontWeight.bold,
              fontSize: Styles.textSize,
              lineHeight: Styles.textLineHeight,
            ),
          ],
        ),
      );
}
