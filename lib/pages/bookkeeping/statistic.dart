import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/utils/money_format.dart';
import 'package:doit/constants/styles.dart';

class Statistic extends StatelessWidget {
  const Statistic({super.key, required this.title, required this.amount});

  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 12.h),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Styles.PrimaryTextColor,
                  fontSize: Styles.smallTextSize,
                  height: Styles.smallTextLineHeight / Styles.smallTextSize,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                moneyFormat(amount),
                style: TextStyle(
                  color: Styles.PrimaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: Styles.statisticTextSize,
                  height:
                      Styles.statisticTextLineHeight / Styles.statisticTextSize,
                ),
              ),
            ],
          ),
        ),
      );
}
