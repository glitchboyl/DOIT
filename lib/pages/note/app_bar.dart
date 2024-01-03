import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/providers/note.dart';
import 'package:doit/providers/theme.dart';
import 'package:doit/utils/toast.dart';
import 'package:doit/utils/show_confirm_dialog.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';

class NotesPageAppBar extends AppBarBuilder {
  const NotesPageAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBarBuilder(
      leading: SVGIconButton(
        isDarkMode(context) ? Ico.BackDark : Ico.Back,
        onPressed: () => Navigator.pop(context),
      ),
      trailings: [
        SVGIconButton(
          Ico.Edit,
          color: isDarkMode(context)
              ? DarkStyles.PrimaryTextColor
              : LightStyles.PrimaryTextColor,
          onPressed: () => Navigator.pushNamed(context, '/note_publish'),
        ),
        SVGIconButton(
          Ico.Trash,
          color: isDarkMode(context)
              ? DarkStyles.PrimaryTextColor
              : LightStyles.PrimaryTextColor,
          onPressed: () {
            final _provider = Provider.of<NoteProvider>(context, listen: false);
            showConfirmDialog(
              '确定要删除这篇随记吗？',
              context: context,
              danger: true,
              onConfirm: (context) async => {
                await _provider.delete(_provider.focusedNote!),
                Navigator.pop(context),
                Future.delayed(
                  const Duration(milliseconds: 100),
                  () => Toast.show(
                    context,
                    text: '删除成功',
                  ),
                ),
                Navigator.pop(context),
              },
            );
          },
        ),
      ],
    );
  }
}
