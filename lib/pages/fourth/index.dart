import 'package:flutter/cupertino.dart';
import 'package:doit/widgets/navigation_bar.dart';
import 'package:doit/constants/colors.dart';

class FourthTab extends StatefulWidget {
  @override
  _FourthTabState createState() => _FourthTabState();
}

class _FourthTabState extends State<FourthTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navigationBar(middle: const Text('Fourth')),
      child: Container(
        child: Text('oh yessir'),
      ),
      backgroundColor: Colors.GeneralBackgroundColor,
    );
  }
}
