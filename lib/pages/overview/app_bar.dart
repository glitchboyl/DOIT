import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/time_picker.dart';
import 'package:doit/widgets/time_picker_drawer.dart';
import 'package:doit/models/overview.dart';
import 'package:doit/providers/to_do_list.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/keys.dart';

class OverviewPageAppBar extends AppBarBuilder {
  const OverviewPageAppBar({super.key});
  @override
  Widget build(BuildContext context) => Container(
        child: Consumer<ToDoListProvider>(
          builder: (context, provider, _) {
            final colorScheme = Theme.of(context).colorScheme;
            final isDarkMode = Theme.of(context).brightness == Brightness.dark;

            return AppBarBuilder(
              leading: SVGIconButton(
                provider.overviewMode == OverviewMode.Day
                    ? isDarkMode
                        ? Ico.OverviewByMonthDark
                        : Ico.OverviewByMonth
                    : isDarkMode
                        ? Ico.OverviewByDayDark
                        : Ico.OverviewByDay,
                onPressed: provider.toggleOverviewMode,
              ),
              title: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${!provider.focusedDate.isSameYear(nowTime) ? '${provider.focusedDate.year}.' : ''}${provider.focusedDate.month}月',
                      style: TextStyles.greatTextStyle,
                    ),
                    SizedBox(width: 4),
                    SVGIcon(
                      isDarkMode ? Ico.ArrowDark : Ico.Arrow,
                      width: MEAS.arrowLength,
                      height: MEAS.arrowLength,
                    ),
                  ],
                ),
                onTap: () => showBottomDrawer(
                  context: context,
                  backgroundColor: colorScheme.regularBaseColor,
                  builder: (context) => TimePickerDrawer(
                    provider.focusedDate,
                    mode: provider.overviewMode == OverviewMode.Day
                        ? CupertinoDatePickerMode.date
                        : CupertinoDatePickerMode.ym,
                    onConfirmed: (time) {
                      provider.focusDate(
                        DateTime(
                          time.year,
                          time.month,
                          provider.overviewMode == OverviewMode.Day
                              ? time.day
                              : 1,
                        ),
                      );
                      if (provider.overviewMode == OverviewMode.Day) {
                        (Keys.calendarRow.currentState as dynamic)
                            .updateFocusedIndex();
                      } else {
                        (Keys.calendarView.currentState as dynamic)
                            .updateFocusedDay();
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      );
}
