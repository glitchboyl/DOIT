import 'package:doit/widgets/text.dart';
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
            TextBuilder(
              text,
              color: Styles.PrimaryTextColor,
              fontSize: Styles.textSize,
              lineHeight: Styles.textLineHeight,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 88),
          ],
        ),
      );
}
