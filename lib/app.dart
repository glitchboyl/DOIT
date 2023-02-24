import 'package:flutter/cupertino.dart';

import 'first/index.dart';
import 'second.dart';
import 'styles.dart';

class DOITApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
            ),
          ],
          backgroundColor: Styles.tabBarColor,
          height: 49,
          border: Border(
            top: BorderSide(color: Styles.tabBarColor),
          ),
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 1:
              return SecondTab();
            case 0:
            default:
              return FirstTab();
          }
        },
      ),
    );
  }
}
