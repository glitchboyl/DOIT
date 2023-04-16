import 'package:flutter/material.dart';
import 'package:doit/widgets/icon.dart';
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
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
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
            color: colorScheme.greyColor,
            iconWidth: MEAS.bookkeepingItemTypeIconLength,
            iconHeight: MEAS.bookkeepingItemTypeIconLength,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.regularTextStyle.copyWith(
                  color: colorScheme.primaryTextColor,
                ),
              ),
              Text(
                subTitle,
                style: TextStyles.smallTextStyle.copyWith(
                  color: colorScheme.secondaryTextColor,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            '${type == BookkeepingItemType.Incomes ? '+' : '-'}${moneyFormat(amount)}',
            style: TextStyles.regularTextStyle.copyWith(
              color: type == BookkeepingItemType.Incomes
                  ? colorScheme.primaryColor
                  : colorScheme.dangerousColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
