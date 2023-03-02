import 'package:flutter/material.dart';
import 'app_bar.dart';

class BookkeepingPage extends StatefulWidget {
  const BookkeepingPage({super.key});
  @override
  _BookkeepingPageState createState() => _BookkeepingPageState();

  static final appBar = ({Key? key}) => BookkeepingPageAppBar(key: key);
}

class _BookkeepingPageState extends State<BookkeepingPage> {
  @override
  Widget build(BuildContext context) => Container(
        child: Text('oh yessir'),
      );
}
