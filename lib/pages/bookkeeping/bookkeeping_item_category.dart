import 'package:flutter/widgets.dart';
import 'package:doit/widgets/icon.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingItemCategoryWidget extends StatelessWidget {
  const BookkeepingItemCategoryWidget({
    super.key,
    required this.icon,
    required this.text,
    this.isActived = false,
    required this.onTap,
  });

  final String icon;
  final String text;
  final bool isActived;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            IconBuilder(
              icon,
              width: MEAS.bookkeepingItemDialogCategoryLength,
              height: MEAS.bookkeepingItemDialogCategoryLength,
              margin: EdgeInsets.only(
                bottom: 4,
              ),
              color: Styles.BackgroundColor,
              border: isActived
                  ? Border.all(
                      color: Styles.PrimaryColor,
                      width: 2,
                    )
                  : null,
              borderRadius: BorderRadius.circular(16),
              iconWidth: MEAS.bookkeepingItemDialogCategoryIconLength,
              iconHeight: MEAS.bookkeepingItemDialogCategoryIconLength,
            ),
            TextBuilder(
              text,
              color: isActived ? Styles.PrimaryColor : Styles.PrimaryTextColor,
              fontSize: Styles.smallTextSize,
              lineHeight: Styles.smallTextLineHeight,
            ),
          ],
        ),
        onTap: onTap,
      );
}
