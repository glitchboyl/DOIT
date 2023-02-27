import 'package:flutter/cupertino.dart';
import 'package:doit/models/tab_view_page.dart';
import 'package:doit/pages/first/index.dart';
import 'package:doit/pages/second/index.dart';
import 'package:doit/pages/third/index.dart';
import 'package:doit/pages/fourth/index.dart';
import 'package:doit/widgets/svg.dart';
import 'constants/meas.dart';

class Routes {
  static List<TabViewPage> pages = [
    TabViewPage(
      tabIcon: 'assets/images/first.svg',
      tabActiveIcon: 'assets/images/first_actived.svg',
      viewWidget: (context) => FirstTab(),
      name: "聚焦",
      path: '/first',
    ),
    TabViewPage(
      tabIcon: 'assets/images/second.svg',
      tabActiveIcon: 'assets/images/second_actived.svg',
      viewWidget: (context) => SecondTab(),
      name: "Second",
      path: '/second',
    ),
    TabViewPage(
      tabIcon: 'assets/images/third.svg',
      tabActiveIcon: 'assets/images/third_actived.svg',
      viewWidget: (context) => ThirdTab(),
      name: "Third",
      path: '/third',
    ),
    TabViewPage(
      tabIcon: 'assets/images/third.svg',
      tabActiveIcon: 'assets/images/third_actived.svg',
      viewWidget: (context) => FourthTab(),
      name: "Fourth",
      path: '/fourth',
    ),
  ];

  static List<BottomNavigationBarItem> getTabBarItems() {
    final List<BottomNavigationBarItem> tabBarItems = [];
    for (int i = 0; i < Routes.pages.length; i++) {
      var page = Routes.pages[i];
      tabBarItems.add(
        BottomNavigationBarItem(
          icon: svg(
            page.tabIcon,
            width: MEAS.tabIconWidth,
            height: MEAS.tabIconHeight,
          ),
          activeIcon: svg(
            page.tabActiveIcon,
            width: MEAS.tabIconWidth,
            height: MEAS.tabIconHeight,
          ),
        ),
      );
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
