import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/styles.dart';
import 'interactive_button.dart';
import 'to_do_item_dialog.dart';
import 'svg_icon.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/constants/keys.dart';
import 'package:doit/providers/to_do_list.dart';

class AddButton extends StatelessWidget {
  const AddButton(this.currentPageKey, {super.key});

  final Key currentPageKey;

  @override
  Widget build(context) => InteractiveButton(
        fixedSize: Size(
          MEAS.addButtonLength,
          MEAS.addButtonLength,
        ),
        color: Styles.PrimaryColor,
        activedColor: Styles.PrimaryDeepColor,
        shadowColor: Styles.AddButtonShadowColor,
        elevation: 24.w,
        shape: const CircleBorder(),
        child: const SVGIcon('assets/images/add.svg',
            color: Styles.RegularBaseColor),
        onPressed: () {
          String currentPage = currentPageKey.toString();
          if (currentPage == Keys.SchedulePage.toString() ||
              currentPage == Keys.OverviewPage.toString()) {
            showBottomDrawer(
              context: context,
              builder: (context) => ToDoItemDialog(),
            );
          } else if (currentPage == Keys.NotesPage.toString()) {
            Navigator.pushNamed(context, '/note_publish');
          } else if (currentPage == Keys.BookkeepingPage.toString()) {
            print('qweqwe');
          }
        },
      );
}
