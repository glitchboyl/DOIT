import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/providers/note.dart';
import 'package:doit/utils/show_confirm_dialog.dart';

class NotesPageAppBar extends AppBarBuilder {
  const NotesPageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        leading: SVGIconButton(
          'assets/images/back.svg',
          onPressed: () => Navigator.pop(context),
        ),
        trailings: [
          SVGIconButton(
            'assets/images/edit.svg',
            onPressed: () => Navigator.pushNamed(context, '/note_publish'),
          ),
          SVGIconButton(
            'assets/images/trash.svg',
            onPressed: () {
              final _provider =
                  Provider.of<NoteProvider>(context, listen: false);
              showConfirmDialog(
                context: context,
                content: '确定要删除这篇随记吗？',
                danger: true,
                onConfirm: (context) async => {
                  await _provider.delete(_provider.focusedNote!),
                  Navigator.pop(context),
                  // toast
                  Navigator.pop(context),
                },
              );
            },
          ),
        ],
      );
}
