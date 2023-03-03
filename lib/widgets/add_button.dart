import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/styles.dart';
import 'interactive_button.dart';
import 'add_to_do_item_dialog.dart';
import 'svg_icon.dart';
import 'package:doit/constants/keys.dart';
import 'package:doit/providers/asd.dart';

const Duration _kShow = Duration(milliseconds: 300);
const Duration _kHide = Duration(milliseconds: 300);

class AddButton extends StatefulWidget {
  const AddButton(this.currentPage, {super.key});
  final Key currentPage;
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    initController();
  }

  void initController() {
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = _kShow;
    _animationController.reverseDuration = _kHide;
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(context) => InteractiveButton(
        fixedSize: Size(
          MEAS.addButtonWidth,
          MEAS.addButtonHeight,
        ),
        color: Styles.PrimaryColor,
        activedColor: Styles.PrimaryDeepColor,
        shadowColor: Styles.AddButtonShadowColor,
        elevation: 24.w,
        shape: const CircleBorder(),
        child: const SVGIcon(
          icon: 'assets/images/add_to_do_item.svg',
        ),
        onPressed: () {
          String currentPage = widget.currentPage.toString();
          if (currentPage == Keys.SchedulePage.toString() ||
              currentPage == Keys.OverviewPage.toString()) {
            showModalBottomSheet(
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
            );
          } else if (currentPage == Keys.NotesPage.toString()) {
            testDatabase();
          } else if (currentPage == Keys.BookkeepingPage.toString()) {
            print('qweqwe');
          }
        },
      );
}
