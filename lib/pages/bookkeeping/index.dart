import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';

class BookkeepingPage extends StatefulWidget {
  const BookkeepingPage({Key? key}) : super(key: key);
  @override
  BookkeepingPageState createState() => BookkeepingPageState();
}

class BookkeepingPageState extends State<BookkeepingPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarBuilder(title: const Text('Fourth')),
        body: Container(
          child: Text('oh yessir'),
        ),
      );
}
