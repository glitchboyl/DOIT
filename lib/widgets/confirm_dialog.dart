import 'dart:ui';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Dialog(
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
          color: colorScheme.greyColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      text,
                      style: TextStyles.confirmDialogContentStyle.copyWith(
                        color: colorScheme.primaryTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0.5,
                thickness: 0.5,
                color: colorScheme.deactivedDeepColor,
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
                      color: colorScheme.deactivedDeepColor,
                    ),
                    ConfirmDialogActionButton(
                      text: confirmText,
                      textColor: danger
                          ? colorScheme.dangerousColor
                          : colorScheme.primaryColor,
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
}
