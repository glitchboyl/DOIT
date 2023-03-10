import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/time_picker.dart';
import 'package:doit/widgets/time_picker_drawer.dart';
import 'statistic.dart';
import 'package:doit/providers/bookkeeping.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingStatistics extends StatelessWidget {
  const BookkeepingStatistics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 16,
      child: Container(
        width: MEAS.bookkeepingStatisticsWidth,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage('assets/images/bookkeeping_statistics_bg.png'),
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Styles.BookkeepingStatisticsShadowColor,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Consumer<BookkeepingProvider>(
          builder: (context, provider, _) {
            final focusedMonth = provider.focusedMonth;
            final statistic = provider.statisticsMap[focusedMonth];
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 12,
                    left: 12,
                    right: 12,
                  ),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        TextBuilder(
                          '${focusedMonth.year}.${focusedMonth.month}月',
                          fontSize: Styles.textSize,
                          lineHeight: Styles.textLineHeight,
                        ),
                        SizedBox(width: 4),
                        RotatedBox(
                          quarterTurns: -1,
                          child: SVGIcon(
                            'assets/images/triangle.svg',
                            width: MEAS.arrowLength,
                            height: MEAS.arrowLength,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => showBottomDrawer(
                      context: context,
                      builder: (context) => TimePickerDrawer(
                        focusedMonth,
                        mode: CupertinoDatePickerMode.ym,
                        onConfirmed: (time) => provider.focus(
                          DateTime(time.year, time.month),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Statistic(
                      title: '收入',
                      amount: statistic != null ? statistic[0] : 0,
                    ),
                    Statistic(
                      title: '支出',
                      amount: statistic != null ? statistic[1] : 0,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
