import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/utils/money_format.dart';
import 'package:doit/constants/styles.dart';

class Statistic extends StatelessWidget {
  const Statistic({super.key, required this.title, required this.amount});

  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            children: [
              TextBuilder(
                title,
                color: Styles.PrimaryTextColor,
                fontSize: Styles.smallTextSize,
                lineHeight: Styles.smallTextLineHeight,
              ),
              SizedBox(height: 10.h),
              TextBuilder(
                title,
                color: Styles.PrimaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: Styles.statisticTextSize,
                lineHeight: Styles.statisticTextLineHeight,
              ),
            ],
          ),
        ),
      );
}
