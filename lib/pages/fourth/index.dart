import 'package:flutter/cupertino.dart';
import 'package:doit/styles.dart';

class FourthTab extends StatefulWidget {
  @override
  _FourthTabState createState() => _FourthTabState();
}

class _FourthTabState extends State<FourthTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Styles.NavigatorBarColor,
        middle: const Text('Fourth'),
        border: Border(
          bottom: BorderSide(color: Styles.NavigatorBarColor),
        ),
      ),
      child: Container(
        child: Text('oh yessir'),
      ),
    );
  }
}
