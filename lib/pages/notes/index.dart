import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'note_item.dart';
import 'package:doit/widgets/blank.dart';
import 'package:doit/providers/note.dart';

class NotesPage extends StatelessWidget {
  NotesPage({super.key});
  final List<Widget> _widgets = [
    SizedBox(height: 14),
  ];
  final ScrollController _scrollController = ScrollController();

  NoteProvider getProvider(BuildContext context, {bool listen = true}) =>
      Provider.of<NoteProvider>(
        context,
        listen: listen,
      );

  void buildWidgets(BuildContext context, NoteProvider provider) {
    _widgets.removeRange(1, _widgets.length);
    provider.noteList.forEach(
      (note) => _widgets.add(
        NoteItemWidget(
          note,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Consumer<NoteProvider>(
            builder: (context, provider, _) {
              if (provider.noteList.length == 0) {
                return Blank(
                  '记录是时光的见证者，这一刻由你主导',
                  'assets/images/notes_blank.svg',
                );
              }
              buildWidgets(context, provider);
              if (provider.noteList.length > _widgets.length - 1) {
                Future.delayed(
                  const Duration(milliseconds: 1),
                  () => _scrollController.jumpTo(0),
                );
              }
              return ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index) => _widgets[index],
                itemCount: _widgets.length,
              );
            },
          ),
        ),
      );

  static final appBar = ({Key? key}) => NotesPageAppBar(key: key);
}
