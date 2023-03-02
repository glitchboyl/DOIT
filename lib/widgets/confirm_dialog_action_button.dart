import 'package:flutter/material.dart';
import 'package:doit/widgets/interactive_button.dart';
import 'package:doit/constants/styles.dart';

class ConfirmDialogActionButton extends StatelessWidget {
  const ConfirmDialogActionButton({
    Key? key,
    required this.text,
    this.textColor = Styles.SecondaryTextColor,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => Expanded(
        flex: 1,
        child: InteractiveButton(
          color: Styles.BackgroundColor,
          activedColor: Styles.DialogActionActivedColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(0)),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: Styles.largeTextSize,
              height: Styles.largeTextLineHeight / Styles.largeTextSize,
            ),
          ),
          onPressed: onPressed,
        ),
      );
}
