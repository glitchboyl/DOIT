import 'package:flutter/material.dart';
import 'app_bar.dart';

class BookkeepingPage extends StatefulWidget {
  const BookkeepingPage({Key? key}) : super(key: key);
  @override
  BookkeepingPageState createState() => BookkeepingPageState();

  static final appBar = ({Key? key}) => BookkeepingPageAppBar(key: key);
}

class BookkeepingPageState extends State<BookkeepingPage> {
  @override
  Widget build(BuildContext context) => Container(
        child: Text('oh yessir'),
      );
}
