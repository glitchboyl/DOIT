import 'package:flutter/cupertino.dart';
import 'package:doit/styles.dart';

CupertinoTabBar tabBar(List<BottomNavigationBarItem> items) => CupertinoTabBar(
      items: items,
      backgroundColor: Styles.TabBarColor,
      height: 49,
      border: Border(
        top: BorderSide(color: Styles.TabBarColor),
      ),
    );
