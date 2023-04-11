import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';

class TextButtonBuilder extends StatelessWidget {
  const TextButtonBuilder(
    this.text, {
    super.key,
    required this.onPressed,
    this.style,
    this.padding = EdgeInsets.zero,
    this.shape,
    this.backgroundColor,
  });

  final String text;
  final void Function()? onPressed;
  final TextStyle? style;
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
        child: Text(
          text,
          style: style,
        ),
        onPressed: onPressed,
      );
}
