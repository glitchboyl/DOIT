import 'package:flutter/material.dart';
import 'package:doit/widgets/interactive_button.dart';
import 'package:doit/constants/styles.dart';

class ConfirmDialogActionButton extends StatelessWidget {
  const ConfirmDialogActionButton({
    super.key,
    required this.text,
    this.textColor,
    required this.onPressed,
  });

  final String text;
  final Color? textColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      flex: 1,
      child: InteractiveButton(
        color: colorScheme.greyColor,
        activedColor: colorScheme.dialogActionActivedColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(0)),
        ),
        child: Text(
          text,
          style: TextStyles.largeTextStyle.copyWith(
            color: textColor ?? colorScheme.secondaryTextColor,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
