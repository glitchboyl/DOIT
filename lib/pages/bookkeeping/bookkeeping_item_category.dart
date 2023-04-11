import 'package:flutter/material.dart';
import 'package:doit/widgets/icon.dart';
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
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
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
            color: colorScheme.backgroundColor,
            border: isActived
                ? Border.all(
                    color: colorScheme.primaryColor,
                    width: 2,
                  )
                : null,
            borderRadius: BorderRadius.circular(16),
            iconWidth: MEAS.bookkeepingItemDialogCategoryIconLength,
            iconHeight: MEAS.bookkeepingItemDialogCategoryIconLength,
          ),
          Text(
            text,
            style: TextStyles.smallTextStyle.copyWith(
              color: isActived
                  ? colorScheme.primaryColor
                  : colorScheme.primaryTextColor,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
