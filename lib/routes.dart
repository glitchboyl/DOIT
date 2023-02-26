import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/models/tab_view_page.dart';
import 'package:doit/pages/first/index.dart';
import 'package:doit/pages/second/index.dart';
import 'package:doit/pages/third/index.dart';
import 'package:doit/pages/fourth/index.dart';

final double tabIconWidth = 30;
final double tabIconHeight = 30;

class Routes {
  static List<TabViewPage> pages = [
    TabViewPage(
      tabIcon: Image.asset(
        'assets/images/first.png',
        width: tabIconWidth,
        height: tabIconHeight,
      ),
      tabActiveIcon: Image.asset(
        'assets/images/first_actived.png',
        width: tabIconWidth,
        height: tabIconHeight,
      ),
      viewWidget: (context) => FirstTab(),
      name: "聚焦",
      path: '/first',
    ),
    TabViewPage(
      tabIcon: Image.asset(
        'assets/images/second.png',
        width: tabIconWidth,
        height: tabIconHeight,
      ),
      tabActiveIcon: Image.asset(
        'assets/images/second_actived.png',
        width: tabIconWidth,
        height: tabIconHeight,
      ),
      viewWidget: (context) => SecondTab(),
      name: "Second",
      path: '/second',
    ),
    TabViewPage(
      tabIcon: Image.asset(
        'assets/images/third.png',
        width: tabIconWidth,
        height: tabIconHeight,
      ),
      tabActiveIcon: Image.asset(
        'assets/images/third_actived.png',
        width: tabIconWidth,
        height: tabIconHeight,
      ),
      viewWidget: (context) => ThirdTab(),
      name: "Third",
      path: '/third',
    ),
    TabViewPage(
      tabIcon: Image.asset(
        'assets/images/fourth.png',
        width: tabIconWidth,
        height: tabIconHeight,
      ),
      tabActiveIcon: Image.asset(
        'assets/images/fourth_actived.png',
        width: tabIconWidth,
        height: tabIconHeight,
      ),
      viewWidget: (context) => FourthTab(),
      name: "Fourth",
      path: '/fourth',
    ),
  ];

  static List<BottomNavigationBarItem> getTabBarItems() {
    final List<BottomNavigationBarItem> tabBarItems = [];
    for (int i = 0; i < Routes.pages.length; i++) {
      var page = Routes.pages[i];
      tabBarItems.add(BottomNavigationBarItem(
          icon: page.tabIcon, activeIcon: page.tabActiveIcon));
    }
    return tabBarItems;
  }

  static Map<String, Widget Function(BuildContext)> getRoutesMap() {
    final Map<String, Widget Function(BuildContext)> routesMap = {};
    for (int i = 0; i < Routes.pages.length; i++) {
      var page = Routes.pages[i];
      routesMap[page.path] = page.viewWidget;
    }
    return routesMap;
  }
}
