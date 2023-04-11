import 'package:flutter/widgets.dart';
import 'package:doit/utils/money_format.dart';
import 'package:doit/constants/styles.dart';

class BookkeepingListTitle extends StatelessWidget {
  const BookkeepingListTitle(
    this.timeText, {
    super.key,
    required this.incomes,
    required this.expenses,
  });

  final String timeText;
  final double incomes;
  final double expenses;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(
          top: 12,
        ),
        child: Row(
          children: [
            Text(
              timeText,
              style: TextStyles.smallTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              '收入: ${moneyFormat(incomes)}',
              style: TextStyles.smallTextStyle,
            ),
            SizedBox(width: 12),
            Text(
              '支出: ${moneyFormat(expenses)}',
              style: TextStyles.smallTextStyle,
            ),
          ],
        ),
      );
}
