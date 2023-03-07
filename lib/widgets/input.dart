import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/constants/styles.dart';

class Input extends StatelessWidget {
  Input({
    super.key,
    this.height,
    this.color = Styles.PrimaryTextColor,
    this.fontSize,
    this.lineHeight,
    this.fontWeight,
    this.initialValue,
    this.hintText,
    this.autofocus = false,
    this.maxLines,
    this.maxLength,
    this.border,
    this.onChanged,
  });

  final double? height;
  final Color? color;
  final double? fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
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
          contentPadding: EdgeInsets.symmetric(
            vertical: ((height ?? (Styles.smallTextLineHeight + 24.h)) -
                    (lineHeight ?? Styles.smallTextLineHeight)) /
                2,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Styles.DeactivedDeepColor,
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
        style: TextStyle(
          color: color,
          fontSize: fontSize ?? Styles.smallTextSize,
          height: (lineHeight ?? Styles.smallTextLineHeight) /
              (fontSize ?? Styles.smallTextSize),
        ),
        onChanged: onChanged,
        cursorColor: color,
      );
}
