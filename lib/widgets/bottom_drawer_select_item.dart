import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/constants/styles.dart';

class BottomDrawerSelectItem extends StatelessWidget {
  const BottomDrawerSelectItem({
    super.key,
    this.icon,
    required this.title,
  });

  final Widget? icon;
  final String title;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50.h,
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 10.w),
            ],
            TextBuilder(
              title,
              color: Styles.PrimaryTextColor,
              fontSize: Styles.textSize,
              lineHeight: Styles.textLineHeight,
            ),
          ],
        ),
      );
}
