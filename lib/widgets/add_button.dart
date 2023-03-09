import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'interactive_button.dart';
import 'to_do_item_dialog.dart';
import 'svg_icon.dart';
import 'package:doit/pages/bookkeeping/bookkeeping_item_dialog.dart';
import 'package:doit/providers/note.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/keys.dart';

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
        elevation: 24,
        shape: const CircleBorder(),
        child: const SVGIcon(
          'assets/images/add.svg',
          color: Styles.RegularBaseColor,
        ),
        onPressed: () {
          String currentPage = currentPageKey.toString();
          if (currentPage == Keys.SchedulePage.toString() ||
              currentPage == Keys.OverviewPage.toString()) {
            showBottomDrawer(
              context: context,
              builder: (context) => ToDoItemDialog(),
            );
          } else if (currentPage == Keys.NotesPage.toString()) {
            Provider.of<NoteProvider>(context, listen: false).focus(null);
            Navigator.pushNamed(context, '/note_publish');
          } else if (currentPage == Keys.BookkeepingPage.toString()) {
            showBottomDrawer(
              context: context,
              builder: (context) => BookkeepingItemDialog(),
              // avoidBottomPadding: 116,
              backgroundColor: Styles.BackgroundColor,
            );
          }
        },
      );
}
