import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'styles.dart';

class SecondTab extends StatefulWidget {
  @override
  _SecondTabState createState() {
    return _SecondTabState();
  }
}

class _SecondTabState extends State<SecondTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(builder: (context) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Styles.NavigatorBarColor,
          middle: const Text('Second'),
        ),
        child: CustomScrollView(
          slivers: const <Widget>[
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       return Container(
            //         alignment: Alignment.center,
            //         color: CupertinoColors.activeBlue,
            //         height: 100 + top[index] % 4 * 20.0,
            //         child: Text('Item: ${top[index]}'),
            //       );
            //     },
            //     childCount: top.length,
            //   ),
            // ),
          ],
        ),
        backgroundColor: Styles.GeneralBackgroundColor,
      );
    });
  }
}
