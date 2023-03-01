import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);
  @override
  NotesPageState createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarBuilder(title: const Text('Third')),
        body: Container(
          child: Text('boy next door'),
        ),
      );
}
