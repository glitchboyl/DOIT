import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/constants/styles.dart';

class FourthTab extends StatefulWidget {
  @override
  _FourthTabState createState() => _FourthTabState();
}

class _FourthTabState extends State<FourthTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: const Text('Fourth')),
      body: Container(
        child: Text('oh yessir'),
      ),
      backgroundColor: Styles.GeneralBackgroundColor,
    );
  }
}
