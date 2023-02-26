import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/styles.dart';

// Widget addToDoItemButton(Function() onPressed) => ;

class AddToDoItemButton extends StatefulWidget {
  const AddToDoItemButton(this.onPressed);
  final Function() onPressed;
  @override
  _AddToDoItemButtonState createState() => _AddToDoItemButtonState();
}

class _AddToDoItemButtonState extends State<AddToDoItemButton> {
  Color buttonColor = Styles.AddToDoItemButtonColor;
  @override
  Widget build(context) {
    return Positioned(
      right: 0,
      bottom: 48,
      child: Container(
        width: 52.w,
        height: 52.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Styles.AddToDoItemButtonActiveColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Styles.AddToDoItemButtonShadowColor,
              offset: Offset(0, 12), //阴影y轴偏移量
              blurRadius: 18, //阴影模糊程度
              spreadRadius: -4, //阴影扩散程度
            ),
          ],
        ),
        child: GestureDetector(
          onTapDown: (tapDetails) {
            setState(() => buttonColor = Styles.AddToDoItemButtonActiveColor);
          },
          onTapCancel: () {
            setState(() => buttonColor = Styles.AddToDoItemButtonColor);
          },
          child: CupertinoButton(
            color: buttonColor,
            padding: EdgeInsets.zero,
            pressedOpacity: 1,
            child: Image.asset(
              'assets/images/add_to_do_item.png',
              width: 16.w,
              height: 16.h,
            ),
            onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }
}
