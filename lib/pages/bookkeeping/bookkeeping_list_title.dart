import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/text.dart';
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
          top: 12.h,
        ),
        child: Row(
          children: [
            TextBuilder(
              timeText,
              color: Styles.PrimaryTextColor,
              fontSize: Styles.smallTextSize,
              fontWeight: FontWeight.bold,
              lineHeight: Styles.smallTextLineHeight,
            ),
            Spacer(),
            TextBuilder(
              '收入: ${moneyFormat(incomes)}',
              color: Styles.PrimaryTextColor,
              fontSize: Styles.smallTextSize,
              fontWeight: FontWeight.bold,
              lineHeight: Styles.smallTextLineHeight,
            ),
            SizedBox(width: 12.w),
            TextBuilder(
              '支出: ${moneyFormat(incomes)}',
              color: Styles.PrimaryTextColor,
              fontSize: Styles.smallTextSize,
              fontWeight: FontWeight.bold,
              lineHeight: Styles.smallTextLineHeight,
            ),
          ],
        ),
      );
}
