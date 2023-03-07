import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'note_item.dart';
import 'package:doit/models/note.dart';
import 'package:doit/providers/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  _NotesPageState createState() => _NotesPageState();

  static final appBar = ({Key? key}) => NotesPageAppBar(key: key);
}

class _NotesPageState extends State<NotesPage> {
  NoteProvider getProvider(BuildContext context, {bool listen = true}) =>
      Provider.of<NoteProvider>(
        context,
        listen: listen,
      );

  List<Widget> buildWidgets(BuildContext context) {
    final List<Widget> _widgets = [
      SizedBox(height: 14.h),
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
            left: 16.w,
            right: 16.w,
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
}
