import 'package:flutter/cupertino.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/colors.dart';
import 'package:doit/widgets/svg.dart';

class AddToDoItemButton extends StatefulWidget {
  const AddToDoItemButton(this.onPressed);
  final Function() onPressed;
  @override
  _AddToDoItemButtonState createState() => _AddToDoItemButtonState();
}

class _AddToDoItemButtonState extends State<AddToDoItemButton> {
  Color buttonColor = Colors.AddToDoItemButtonColor;
  @override
  Widget build(context) {
    return Positioned(
      right: 0,
      bottom: 48,
      child: Container(
        width: MEAS.addToDoItemButtonWidth,
        height: MEAS.addToDoItemButtonHeight,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.AddToDoItemButtonActiveColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.AddToDoItemButtonShadowColor,
              offset: Offset(0, 12), //阴影y轴偏移量
              blurRadius: 18, //阴影模糊程度
              spreadRadius: -4, //阴影扩散程度
            ),
          ],
        ),
        child: GestureDetector(
          onTapDown: (tapDetails) {
            setState(() => buttonColor = Colors.AddToDoItemButtonActiveColor);
          },
          onTapCancel: () {
            setState(() => buttonColor = Colors.AddToDoItemButtonColor);
          },
          child: CupertinoButton(
            color: buttonColor,
            padding: EdgeInsets.zero,
            pressedOpacity: 1,
            child: svg(
              'assets/images/add_to_do_item.svg',
              width: MEAS.addToDoItemIconWidth,
              height: MEAS.addToDoItemIconHeight,
            ),
            onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }
}
