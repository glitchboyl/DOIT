import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'confirm_dialog_action_button.dart';
import 'package:doit/constants/styles.dart';

class ConfirmDialogBuilder extends StatelessWidget {
  const ConfirmDialogBuilder({
    Key? key,
    required this.content,
    required this.onConfirm,
    this.danger = false,
  }) : super(key: key);

  final String content;
  final void Function(BuildContext context) onConfirm;
  final bool? danger;

  @override
  Widget build(BuildContext context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 52.w),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(14.r)),
        ),
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 0.h),
          child: Container(
            height: 112.h,
            color: Styles.BackgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Center(child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    content,
                    style: TextStyle(
                      color: Styles.PrimaryTextColor,
                      fontSize: Styles.smallTextSize,
                      height:
                          Styles.dialogContentLineHeight / Styles.smallTextSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ))),
                Divider(
                  height: 0.5.h,
                  thickness: 0.5.w,
                  color: Styles.DeactivedDeepColor,
                ),
                Container(
                  height: 42.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ConfirmDialogActionButton(
                        text: '取消',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      VerticalDivider(
                        width: 1.w,
                        thickness: 0.5.w,
                        color: Styles.DeactivedDeepColor,
                      ),
                      ConfirmDialogActionButton(
                        text: '删除',
                        textColor: danger!
                            ? Styles.DangerousColor
                            : Styles.PrimaryColor,
                        onPressed: () => onConfirm(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
