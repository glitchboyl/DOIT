import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'note_item.dart';
import 'package:doit/providers/note.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  NoteProvider getProvider(BuildContext context, {bool listen = true}) =>
      Provider.of<NoteProvider>(
        context,
        listen: listen,
      );

  List<Widget> buildWidgets(BuildContext context) {
    final List<Widget> _widgets = [
      SizedBox(height: 14),
    ];
    Provider.of<NoteProvider>(
      context,
      listen: false,
    ).noteList.forEach((note) {
      _widgets.add(
        NoteItemWidget(
          note,
        ),
      );
    });
    return _widgets;
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
              final _widgets = buildWidgets(context);
              return ListView.builder(
                itemBuilder: (context, index) => _widgets[index],
                itemCount: _widgets.length,
              );
            },
          ),
        ),
      );
  static final appBar = ({Key? key}) => NotesPageAppBar(key: key);
}
