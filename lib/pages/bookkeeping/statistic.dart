import 'package:flutter/widgets.dart';
import 'package:doit/widgets/text.dart';
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
              TextBuilder(
                type == BookkeepingItemType.Incomes ? '收入' : '支出',
                color: Styles.PrimaryTextColor,
                fontSize: Styles.smallTextSize,
                lineHeight: Styles.smallTextLineHeight,
              ),
              SizedBox(height: 10),
              TextBuilder(
                '${type == BookkeepingItemType.Incomes ? '+' : '-'}${moneyFormat(amount)}',
                color: Styles.PrimaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: Styles.amountTextSize,
                lineHeight: Styles.amountTextLineHeight,
              ),
            ],
          ),
        ),
      );
}
