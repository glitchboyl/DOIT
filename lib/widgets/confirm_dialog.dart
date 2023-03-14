import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:doit/widgets/text.dart';
import 'confirm_dialog_action_button.dart';
import 'package:doit/constants/styles.dart';

class ConfirmDialogBuilder extends StatelessWidget {
  const ConfirmDialogBuilder(
    this.text, {
    super.key,
    this.confirmText = '确定',
    required this.onConfirm,
    this.danger = false,
  });

  final String text;
  final String confirmText;
  final void Function(BuildContext context) onConfirm;
  final bool danger;

  @override
  Widget build(BuildContext context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 52),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(14)),
        ),
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 0),
          child: Container(
            height: 112,
            color: Styles.BackgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: TextBuilder(
                        text,
                        color: Styles.PrimaryTextColor,
                        fontSize: Styles.smallTextSize,
                        lineHeight: Styles.confirmDialogContentLineHeight,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: Styles.DeactivedDeepColor,
                ),
                Container(
                  height: 42,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ConfirmDialogActionButton(
                        text: '取消',
                        onPressed: () => Navigator.pop(context),
                      ),
                      VerticalDivider(
                        width: 1,
                        thickness: 0.5,
                        color: Styles.DeactivedDeepColor,
                      ),
                      ConfirmDialogActionButton(
                        text: confirmText,
                        textColor: danger
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
