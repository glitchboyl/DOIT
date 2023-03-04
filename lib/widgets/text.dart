import 'package:flutter/widgets.dart';

class TextBuilder extends StatelessWidget {
  const TextBuilder(
    this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.lineHeight,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  final String data;
  final Color? color;
  final double? fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => Text(
        data,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          height: lineHeight != null && fontSize != null
              ? (lineHeight! / fontSize!)
              : 1,
          fontWeight: fontWeight,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
      );
}
