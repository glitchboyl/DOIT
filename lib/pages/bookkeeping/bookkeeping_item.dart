import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/models/bookkeeping_item.dart';
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
        key: item.id,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Styles.RegularBaseColor,
        ),
        margin: EdgeInsets.only(top: 10.w),
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Container(
              width: MEAS.bookkeepingItemTypeWidth,
              height: MEAS.bookkeepingItemTypeHeight,
              margin: EdgeInsets.only(
                right: 8.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Styles.BackgroundColor,
              ),
              child: SVGIcon(
                icon:
                    'assets/images/${item.type == BookkeepingItemType.Incomes ? 'incomes' : 'expenses'}.svg',
                width: MEAS.bookkeepingItemTypeIconWidth,
                height: MEAS.bookkeepingItemTypeIconHeight,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    color: Styles.PrimaryTextColor,
                    fontSize: Styles.textSize,
                    height: Styles.textLineHeight / Styles.textSize,
                  ),
                ),
                Text(
                  getClockTime(item.time),
                  style: TextStyle(
                    color: Styles.SecondaryTextColor,
                    fontSize: Styles.smallTextSize,
                    height: Styles.smallTextLineHeight / Styles.smallTextSize,
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox.shrink()),
            Text(
              '${item.type == BookkeepingItemType.Incomes ? '+' : '-'}${moneyFormat(item.amount)}',
              style: TextStyle(
                color: item.type == BookkeepingItemType.Incomes
                    ? Styles.PrimaryColor
                    : Styles.DangerousColor,
                fontWeight: FontWeight.bold,
                fontSize: Styles.textSize,
                height: Styles.textLineHeight / Styles.textSize,
              ),
            ),
          ],
        ),
      );
}
