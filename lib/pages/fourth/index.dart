import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/keys.dart';

class FourthTab extends StatefulWidget {
  @override
  FourthTabState createState() => FourthTabState();
}

class FourthTabState extends State<FourthTab> {
  @override
  Widget build(BuildContext context) => Scaffold(
        key: Keys.Fourth,
        appBar: AppBarBuilder(title: const Text('Fourth')),
        body: Container(
          child: Text('oh yessir'),
        ),
        // backgroundColor: Styles.PageBackgroundColor,
      );
}
