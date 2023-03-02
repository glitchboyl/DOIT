import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'add_to_do_item_dialog.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/styles.dart';
import 'interactive_button.dart';
import 'svg_icon.dart';

class AddToDoItemButton extends StatefulWidget {
  const AddToDoItemButton({Key? key}) : super(key: key);
  @override
  AddToDoItemButtonState createState() => AddToDoItemButtonState();
}

class AddToDoItemButtonState extends State<AddToDoItemButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    initController();
  }

  void initController() {
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(milliseconds: 350);
    _animationController.reverseDuration = const Duration(milliseconds: 250);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(context) => InteractiveButton(
        fixedSize: Size(
          MEAS.addToDoItemButtonWidth,
          MEAS.addToDoItemButtonHeight,
        ),
        color: Styles.PrimaryColor,
        activedColor: Styles.PrimaryDeepColor,
        shadowColor: Styles.AddToDoItemButtonShadowColor,
        elevation: 24.w,
        shape: const CircleBorder(),
        child: const SVGIcon(
          icon: 'assets/images/add_to_do_item.svg',
        ),
        onPressed: () => showModalBottomSheet(
          context: context,
          transitionAnimationController: _animationController,
          isScrollControlled: true,
          backgroundColor: Styles.RegularBaseColor,
          barrierColor: Styles.BarrierColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(MEAS.addToDoItemDialogRadius),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          builder: (BuildContext context) => AddToDoItemDialog(),
        ),
      );
}
