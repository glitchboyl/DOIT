import 'package:flutter/material.dart';

class InteractiveButton extends StatefulWidget {
  const InteractiveButton({
    Key? key,
    this.fixedSize,
    required this.color,
    this.activedColor,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.child,
    required this.onPressed,
  }) : super(key: key);
  final Size? fixedSize;
  final Color color;
  final Color? activedColor;
  final Color? shadowColor;
  final double? elevation;
  final OutlinedBorder? shape;
  final Widget? child;
  final void Function() onPressed;

  @override
  InteractiveButtonState createState() => InteractiveButtonState();
}

class InteractiveButtonState extends State<InteractiveButton> {
  late Color _buttonColor;

  @override
  void initState() {
    super.initState();
    _buttonColor = widget.color;
  }

  @override
  Widget build(context) => GestureDetector(
        onTapDown: (tapDetails) {
          if (widget.activedColor != null &&
              widget.activedColor != widget.color) {
            setState(() {
              _buttonColor = widget.activedColor!;
            });
          }
        },
        onTapCancel: () {
          setState(() {
            _buttonColor = widget.color;
          });
        },
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: widget.fixedSize,
            backgroundColor: _buttonColor,
            foregroundColor: _buttonColor,
            shadowColor: widget.shadowColor ?? Colors.transparent,
            elevation: widget.elevation,
            splashFactory: NoSplash.splashFactory,
            shape: widget.shape,
          ),
          child: widget.child,
          onPressed: widget.onPressed,
        ),
      );
}
