import 'package:flutter/cupertino.dart';
import 'package:doit/widgets/navigation_bar.dart';
import 'package:doit/constants/colors.dart';

class ThirdTab extends StatefulWidget {
  @override
  _ThirdTabState createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navigationBar(middle: const Text('Third')),
      child: Container(
        child: Text('boy next door'),
      ),
      backgroundColor: Colors.GeneralBackgroundColor,
    );
  }
}
