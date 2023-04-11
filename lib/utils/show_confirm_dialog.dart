import 'package:flutter/material.dart';
import 'package:doit/widgets/confirm_dialog.dart';
import 'package:doit/constants/styles.dart';

final showConfirmDialog = (
  String text, {
  required BuildContext context,
  confirmText = '确定',
  required void Function(BuildContext) onConfirm,
  bool danger = false,
}) =>
    showDialog(
      context: context,
      builder: (context) => ConfirmDialogBuilder(
        text,
        confirmText: confirmText,
        onConfirm: onConfirm,
        danger: danger,
        key: UniqueKey(),
      ),
      barrierDismissible: false,
      barrierColor: Theme.of(context).colorScheme.barrierColor,
    );
