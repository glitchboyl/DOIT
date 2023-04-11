import 'package:flutter/material.dart';
import 'package:doit/constants/styles.dart';

class Input extends StatelessWidget {
  Input({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
    this.style,
    this.color,
    this.initialValue,
    this.hintText,
    this.autofocus = false,
    this.maxLines,
    this.maxLength,
    this.border,
    this.onChanged,
  });

  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final Color? color;
  final String? initialValue;
  final String? hintText;
  final bool autofocus;
  final int? maxLines;
  final int? maxLength;
  final InputBorder? border;
  final void Function(String)? onChanged;

  @override
  Widget build(context) => TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          contentPadding: padding,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.deactivedDeepColor,
          ),
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          counterText: "",
          isDense: true,
        ),
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: TextInputType.multiline,
        autofocus: autofocus,
        style: (style ?? TextStyles.smallTextStyle).copyWith(
          color: color,
        ),
        onChanged: onChanged,
        cursorColor: color,
      );
}
