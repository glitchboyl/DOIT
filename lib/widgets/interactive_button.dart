import 'package:flutter/material.dart';

class InteractiveButton extends StatefulWidget {
  const InteractiveButton({
    super.key,
    required this.color,
    this.width,
    this.height,
    this.activedColor,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.child,
    required this.onPressed,
  });

  final double? width;
  final double? height;
  final Color color;
  final Color? activedColor;
  final Color? shadowColor;
  final double? elevation;
  final OutlinedBorder? shape;
  final Widget? child;
  final void Function() onPressed;

  @override
  _InteractiveButtonState createState() => _InteractiveButtonState();
}

class _InteractiveButtonState extends State<InteractiveButton> {
  late Color _buttonColor;

  @override
  void initState() {
    super.initState();
    _buttonColor = widget.color;
  }

  @override
  Widget build(context) => SizedBox(
        width: widget.width,
        height: widget.height,
        child: GestureDetector(
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
              backgroundColor: _buttonColor,
              foregroundColor: _buttonColor,
              shadowColor: widget.shadowColor ?? Colors.transparent,
              elevation: widget.elevation,
              shape: widget.shape,
              splashFactory: NoSplash.splashFactory,
              alignment: Alignment.center,
              padding: EdgeInsets.zero,
            ),
            clipBehavior: Clip.antiAlias,
            child: widget.child,
            onPressed: widget.onPressed,
          ),
        ),
      );
}
