import 'package:flutter/material.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/widgets/svg.dart';

class AddToDoItemButton extends StatefulWidget {
  const AddToDoItemButton(this.onPressed);
  final Function() onPressed;
  @override
  _AddToDoItemButtonState createState() => _AddToDoItemButtonState();
}

class _AddToDoItemButtonState extends State<AddToDoItemButton> {
  Color _buttonColor = Styles.AddToDoItemButtonColor;
  @override
  Widget build(context) {
    return Positioned(
      right: 0,
      bottom: 48,
      child: GestureDetector(
        onTapDown: (tapDetails) {
          setState(() => _buttonColor = Styles.AddToDoItemButtonActiveColor);
        },
        onTapCancel: () {
          setState(() => _buttonColor = Styles.AddToDoItemButtonColor);
        },
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(
              MEAS.addToDoItemButtonWidth,
              MEAS.addToDoItemButtonHeight,
            ),
            backgroundColor: _buttonColor,
            foregroundColor: _buttonColor,
            shadowColor: Styles.AddToDoItemButtonShadowColor,
            elevation: 24,
            splashFactory: NoSplash.splashFactory,
            shape: CircleBorder(),
          ),
          child: svg(
            'assets/images/add_to_do_item.svg',
            width: MEAS.addToDoItemIconWidth,
            height: MEAS.addToDoItemIconHeight,
          ),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
