import 'package:flutter/material.dart';
import 'package:doit/widgets/confirm_dialog.dart';
import 'package:doit/constants/styles.dart';

final showConfirmDialog = (
  String text, {
  required BuildContext context,
  required void Function(BuildContext) onConfirm,
  bool? danger,
}) =>
    showDialog(
      context: context,
      builder: (context) => ConfirmDialogBuilder(
        text,
        key: UniqueKey(),
        onConfirm: onConfirm,
        danger: danger,
      ),
      barrierDismissible: false,
      barrierColor: Styles.BarrierColor,
    );
