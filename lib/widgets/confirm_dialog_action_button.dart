import 'package:flutter/widgets.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/interactive_button.dart';
import 'package:doit/constants/styles.dart';

class ConfirmDialogActionButton extends StatelessWidget {
  const ConfirmDialogActionButton({
    super.key,
    required this.text,
    this.textColor = Styles.SecondaryTextColor,
    required this.onPressed,
  });

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
          child: TextBuilder(
            text,
            color: textColor,
            fontSize: Styles.greatTextSize,
            lineHeight: Styles.greatTextLineHeight,
          ),
          onPressed: onPressed,
        ),
      );
}
