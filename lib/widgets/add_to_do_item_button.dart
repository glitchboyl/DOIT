import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'add_to_do_item_dialog.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/widgets/svg_icon.dart';

class AddToDoItemButton extends StatefulWidget {
  @override
  _AddToDoItemButtonState createState() => _AddToDoItemButtonState();
}

class _AddToDoItemButtonState extends State<AddToDoItemButton>
    with TickerProviderStateMixin {
  Color _buttonColor = Styles.AddToDoItemButtonColor;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    initController();
  }

  void initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 350);
    controller.reverseDuration = const Duration(milliseconds: 250);
  }

  @override
  Widget build(context) {
    return GestureDetector(
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
            shape: const CircleBorder(),
          ),
          child: SVGIcon(
            icon: 'assets/images/add_to_do_item.svg',
          ),
          onPressed: () => showModalBottomSheet(
            context: context,
            transitionAnimationController: controller,
            isScrollControlled: true,
            backgroundColor: Styles.AddToDoItemDialogBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: AddToDoItemDialog.radius,
            ),
            builder: (BuildContext context) => AddToDoItemDialog(),
          ),
        ),
      );}
}
