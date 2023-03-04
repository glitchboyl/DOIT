import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/constants/styles.dart';

class AddToDoItemDialogInput extends StatelessWidget {
  const AddToDoItemDialogInput({
    super.key,
    required this.height,
    this.hintText,
    this.border,
    this.onChanged,
  });

  final double height;
  final String? hintText;
  final InputBorder? border;
  final void Function(String)? onChanged;

  @override
  Widget build(context) => TextFormField(
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
        style: TextStyle(
          color: Styles.PrimaryTextColor,
          fontSize: Styles.smallTextSize,
          height: Styles.smallTextLineHeight / Styles.smallTextSize,
        ),
        onChanged: onChanged,
      );
}
