import 'package:flutter/material.dart';
import 'package:doit/widgets/confirm_dialog.dart';
import 'package:doit/constants/styles.dart';

final showConfirmDialog = ({
  required BuildContext context,
  required String content,
  required void Function(BuildContext) onConfirm,
  bool? danger,
}) =>
    showDialog(
      context: context,
      builder: (context) => ConfirmDialogBuilder(
          key: UniqueKey(),
          content: content,
          onConfirm: onConfirm,
          danger: danger),
      barrierDismissible: false,
      barrierColor: Styles.BarrierColor,
    );
