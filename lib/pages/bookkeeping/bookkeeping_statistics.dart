import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'statistic.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingStatistics extends StatelessWidget {
  const BookkeepingStatistics({
    super.key,
    required this.incomes,
    required this.expenses,
  });

  final double incomes;
  final double expenses;

  @override
  Widget build(BuildContext context) => Positioned(
        top: MediaQuery.of(context).padding.top,
        left: 16.w,
        child: Container(
          width: MEAS.bookkeepingStatisticsWidth,
          decoration: BoxDecoration(
            color: Styles.RegularBaseColor,
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            boxShadow: [
              BoxShadow(
                color: Styles.BookkeepingStatisticsShadowColor,
                offset: Offset(0, 2.h),
                blurRadius: 6.h,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 12.h,
                  left: 12.w,
                  right: 12.w,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  '2023.2月',
                  style: TextStyle(
                    fontSize: Styles.largeTextSize,
                    height: Styles.largeTextLineHeight / Styles.largeTextSize,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Statistic(title: '收入', amount: incomes),
                  Statistic(title: '支出', amount: expenses),
                ],
              ),
            ],
          ),
        ),
      );
}
