import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/time_picker.dart';
import 'package:doit/widgets/time_picker_drawer.dart';
import 'statistic.dart';
import 'package:doit/providers/bookkeeping.dart';
import 'package:doit/models/bookkeeping.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/providers/theme.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/constants/images.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingStatistics extends StatelessWidget {
  const BookkeepingStatistics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(
              isDarkMode(context)
                  ? Images.BookkeepingStatisticsBackgroundDark
                  : Images.BookkeepingStatisticsBackground,
            ),
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.bookkeepingStatisticsShadowColor,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Consumer<BookkeepingProvider>(
          builder: (context, provider, _) {
            final focusedMonth = provider.focusedMonth;
            final statistic = provider
                .statisticsMap[BookkeepingStatisticType.Month]?[focusedMonth];
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
                        Text(
                          '${focusedMonth.year}.${focusedMonth.month}月',
                          style: TextStyles.regularTextStyle.copyWith(
                            color: colorScheme.primaryTextColor,
                          ),
                        ),
                        SizedBox(width: 4),
                        RotatedBox(
                          quarterTurns: -1,
                          child: SVGIcon(
                            Ico.Triangle,
                            width: MEAS.indicatorLength,
                            height: MEAS.indicatorLength,
                            color: colorScheme.primaryTextColor,
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
                      type: BookkeepingItemType.Incomes,
                      amount: getAllStatisticsSum(statistic?[0].values),
                    ),
                    Statistic(
                      type: BookkeepingItemType.Expenses,
                      amount: getAllStatisticsSum(statistic?[1].values),
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
