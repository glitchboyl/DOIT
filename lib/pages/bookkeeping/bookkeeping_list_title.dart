import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Text(
              timeText,
              style: TextStyle(
                fontSize: Styles.smallTextSize,
                fontWeight: FontWeight.bold,
                height: Styles.smallTextLineHeight / Styles.smallTextSize,
                color: Styles.PrimaryTextColor,
              ),
            ),
            Expanded(child: SizedBox.shrink()),
            Text(
              '收入: ${moneyFormat(incomes)}',
              style: TextStyle(
                fontSize: Styles.smallTextSize,
                height: Styles.smallTextLineHeight / Styles.smallTextSize,
                color: Styles.PrimaryTextColor,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              '支出: ${moneyFormat(incomes)}',
              style: TextStyle(
                fontSize: Styles.smallTextSize,
                height: Styles.smallTextLineHeight / Styles.smallTextSize,
                color: Styles.PrimaryTextColor,
              ),
            ),
          ],
        ),
      );
}
