import 'package:flutter/material.dart';
import 'text.dart';
import 'package:doit/constants/styles.dart';

class TextButtonBuilder extends StatelessWidget {
  const TextButtonBuilder(
    this.text, {
    super.key,
    required this.onPressed,
    this.color,
    this.fontSize,
    this.lineHeight,
    this.fontWeight,
    this.padding = EdgeInsets.zero,
    this.shape,
    this.backgroundColor = Styles.RegularBaseColor,
  });

  final String text;
  final void Function()? onPressed;
  final Color? color;
  final double? fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => TextButton(
        style: TextButton.styleFrom(
          padding: padding,
          shape: shape,
          backgroundColor: backgroundColor,
          foregroundColor: backgroundColor,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: TextBuilder(
          text,
          color: color,
          fontSize: fontSize,
          lineHeight: lineHeight,
          fontWeight: fontWeight,
        ),
        onPressed: onPressed,
      );
}
