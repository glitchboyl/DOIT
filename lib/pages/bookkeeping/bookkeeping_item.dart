import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/icon.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/utils/money_format.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingItemWidget extends StatelessWidget {
  const BookkeepingItemWidget(this.item);

  final BookkeepingItem item;

  @override
  Widget build(BuildContext context) => Container(
        key: ValueKey(item.id),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Styles.RegularBaseColor,
        ),
        margin: EdgeInsets.only(top: 10.w),
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            IconBuilder(
              'assets/images/${item.type == BookkeepingItemType.Incomes ? 'incomes' : 'expenses'}.svg',
              width: MEAS.bookkeepingItemTypeLength,
              height: MEAS.bookkeepingItemTypeLength,
              margin: EdgeInsets.only(
                right: 8.w,
              ),
              borderRadius: BorderRadius.circular(8.r),
              color: Styles.BackgroundColor,
              iconWidth: MEAS.bookkeepingItemTypeIconLength,
              iconHeight: MEAS.bookkeepingItemTypeIconLength,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBuilder(
                  item.title,
                  color: Styles.PrimaryTextColor,
                  fontSize: Styles.textSize,
                  lineHeight: Styles.textLineHeight,
                ),
                TextBuilder(
                  getClockTime(item.time),
                  color: Styles.SecondaryTextColor,
                  fontSize: Styles.smallTextSize,
                  lineHeight: Styles.smallTextLineHeight,
                ),
              ],
            ),
            Spacer(),
            TextBuilder(
              '${item.type == BookkeepingItemType.Incomes ? '+' : '-'}${moneyFormat(item.amount)}',
              color: item.type == BookkeepingItemType.Incomes
                  ? Styles.PrimaryColor
                  : Styles.DangerousColor,
              fontWeight: FontWeight.bold,
              fontSize: Styles.textSize,
              lineHeight: Styles.textLineHeight,
            ),
          ],
        ),
      );
}
