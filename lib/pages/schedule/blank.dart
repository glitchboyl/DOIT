import 'package:doit/widgets/text.dart';
import 'package:flutter/widgets.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class ScheduleBlank extends StatelessWidget {
  const ScheduleBlank({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SVGIcon(
              'assets/images/schedule_blank.svg',
              width: MEAS.blankImageLength,
              height: MEAS.blankImageLength,
            ),
            SizedBox(height: 24),
            TextBuilder(
              '没有安排就是最好的安排',
              color: Styles.PrimaryTextColor,
              fontSize: Styles.textSize,
              lineHeight: Styles.textLineHeight,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      );
}
