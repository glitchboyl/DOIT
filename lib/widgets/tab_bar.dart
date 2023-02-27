import 'package:flutter/cupertino.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/colors.dart';

CupertinoTabBar tabBar(List<BottomNavigationBarItem> items) => CupertinoTabBar(
      items: items,
      backgroundColor: Colors.TabBarColor,
      height: MEAS.tabBarHeight,
      border: Border(
        top: BorderSide(color: Colors.TabBarColor),
      ),
    );
