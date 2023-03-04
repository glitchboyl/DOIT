import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/constants/styles.dart';

class ToDoItemDialogInput extends StatelessWidget {
  const ToDoItemDialogInput({
    super.key,
    required this.height,
    this.initialValue,
    this.hintText,
    this.autofocus = false,
    this.border,
    this.onChanged,
  });

  final double height;
  final String? initialValue;
  final String? hintText;
  final bool autofocus;
  final InputBorder? border;
  final void Function(String)? onChanged;

  @override
  Widget build(context) => TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: (height - Styles.smallTextLineHeight) / 2.h,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Styles.DeactivedDeepColor,
          ),
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          // hintStyle:
        ),
        autofocus: autofocus,
        style: TextStyle(
          color: Styles.PrimaryTextColor,
          fontSize: Styles.smallTextSize,
          height: Styles.smallTextLineHeight / Styles.smallTextSize,
        ),
        onChanged: onChanged,
      );
}
