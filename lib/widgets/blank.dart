import 'package:flutter/widgets.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class Blank extends StatelessWidget {
  const Blank(
    this.text,
    this.image, {
    super.key,
  });

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SVGIcon(
              image,
              width: MEAS.blankImageLength,
              height: MEAS.blankImageLength,
            ),
            SizedBox(height: 24),
            Text(
              text,
              style: TextStyles.regularTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 88),
          ],
        ),
      );
}
