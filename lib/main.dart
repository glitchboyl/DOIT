import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pages/schedule/drawer.dart';
import 'widgets/app_bar.dart';
import 'widgets/add_to_do_item_button.dart';
import 'widgets/bottom_navigation_bar.dart';
import 'widgets/svg_icon.dart';
import 'models/navigation.dart';
import 'models/floating_action_button_location.dart';
import 'models/floating_action_button_animator.dart';
import 'constants/styles.dart';
import 'constants/meas.dart';
import 'constants/keys.dart';

void main() {
  runApp(DOITApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class DOITApp extends StatefulWidget {
  @override
  _DOITAppState createState() => _DOITAppState();
}

class _DOITAppState extends State<DOITApp> {
  int _currentIndex = 0;
  List<BottomNavigationBarItem> _navigationBarItems = [];
  final List<AppBarBuilder> _appBarWidgets = [];
  final List<Widget> _pageWidgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < navigation.length; i++) {
      final page = navigation[i];
      _navigationBarItems.add(
        BottomNavigationBarItem(
          icon: SVGIcon(
            icon: page.icon,
            width: MEAS.bottomNavigationBarIconWidth,
            height: MEAS.bottomNavigationBarIconHeight,
          ),
          activeIcon: SVGIcon(
            icon: page.activeIcon,
            width: MEAS.bottomNavigationBarIconWidth,
            height: MEAS.bottomNavigationBarIconHeight,
          ),
          label: '',
        ),
      );
      _appBarWidgets.add(page.appBar());
      _pageWidgets.add(page.widget());
    }
  }

  @override
  Widget build(context) => ScreenUtilInit(
        designSize: Size(MEAS.designSizeWidth, MEAS.designSizeHeight),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: 'Barlow',
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          themeMode: ThemeMode.light,
          home: Scaffold(
            drawerScrimColor: Styles.BarrierColor,
            appBar: _appBarWidgets[_currentIndex],
            body: IndexedStack(index: _currentIndex, children: _pageWidgets),
            drawer: SchedulePageDrawer(),
            drawerEnableOpenDragGesture: false,
            floatingActionButton: Visibility(
              visible: navigation[_currentIndex].name ==
                      Keys.SchedulePage.toString() ||
                  navigation[_currentIndex].name ==
                      Keys.OverviewPage.toString(),
              child: AddToDoItemButton(key: Keys.AddToDoItemButton),
            ),
            floatingActionButtonLocation: FABLocation(
              location: FloatingActionButtonLocation.endDocked,
              offsetX: -16.w,
              offsetY: -MEAS.bottomNavigationBarHeight -
                  MEAS.addToDoItemButtonBottom,
            ),
            floatingActionButtonAnimator: FABAnimator(),
            resizeToAvoidBottomInset: false,
            backgroundColor: Styles.BackgroundColor,
            bottomNavigationBar: BottomNavigationBarBuilder(
              items: _navigationBarItems,
              currentIndex: _currentIndex,
              onTap: (int index) {
                if (_currentIndex != index)
                  setState(() {
                    _currentIndex = index;
                  });
              },
            ),
          ),
        ),
      );
}
