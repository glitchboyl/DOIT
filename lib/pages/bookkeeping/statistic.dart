import 'package:flutter/material.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/utils/money_format.dart';
import 'package:doit/constants/styles.dart';

class Statistic extends StatelessWidget {
  const Statistic({
    super.key,
    required this.type,
    required this.amount,
  });

  final BookkeepingItemType type;
  final double amount;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Text(
                type == BookkeepingItemType.Incomes ? '收入' : '支出',
                style: TextStyles.smallTextStyle,
              ),
              SizedBox(height: 10),
              Text(
                '${type == BookkeepingItemType.Incomes ? '+' : '-'}${moneyFormat(amount)}',
                style: TextStyles.amountTextStyle,
              ),
            ],
          ),
        ),
      );
}
