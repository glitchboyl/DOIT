import 'package:flutter/cupertino.dart';
import 'package:doit/styles.dart';

class SecondTab extends StatefulWidget {
  @override
  _SecondTabState createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Styles.NavigatorBarColor,
        middle: const Text('Second'),
        border: Border(
          bottom: BorderSide(color: Styles.NavigatorBarColor),
        ),
      ),
      child: Container(
        child: Text('ass we can'),
      ),
    );
  }
}
