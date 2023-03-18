import 'package:flutter/widgets.dart';
import 'text_button.dart';
import 'package:doit/constants/styles.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton(
    this.text, {
    super.key,
    required this.onPressed,
    this.isActived = false,
  });

  final String text;
  final void Function() onPressed;
  final bool isActived;

  @override
  Widget build(BuildContext context) => TextButtonBuilder(
        text,
        color: isActived ? Styles.PrimaryColor : Styles.PrimaryTextColor,
        fontSize: Styles.largeTextSize,
        lineHeight: Styles.largeTextLineHeight,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(8)),
        ),
        backgroundColor:
            isActived ? Styles.BackgroundColor : Styles.RegularBaseColor,
        onPressed: () => {
          if (!isActived) onPressed(),
        },
      );
}
