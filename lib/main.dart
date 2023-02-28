import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/add_to_do_item_button.dart';
import 'package:doit/widgets/bottom_navigation_bar.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/models/navigation.dart';
import 'constants/styles.dart';
import 'constants/meas.dart';
import 'models/floating_action_button_location.dart';

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
  List<Widget> _pageWidgets = [];

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
      _pageWidgets.add(page.widget());
    }
  }

  @override
  Widget build(context) => ScreenUtilInit(
        designSize: Size(MEAS.designSizeWidth, MEAS.designSizeHeight),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: 'DIN',
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            themeMode: ThemeMode.light,
            home: Scaffold(
              body: IndexedStack(index: _currentIndex, children: _pageWidgets),
              floatingActionButton:
                  (navigation[_currentIndex].name == 'First' ||
                          navigation[_currentIndex].name == 'Second')
                      ? AddToDoItemButton()
                      : null,
              floatingActionButtonLocation: FABLocation(
                location: FloatingActionButtonLocation.endDocked,
                offsetX: -16.w,
                offsetY: -MEAS.bottomNavigationBarHeight -
                    MEAS.addToDoItemButtonBottom,
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Styles.PageBackgroundColor,
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
          );
        },
      );
}
