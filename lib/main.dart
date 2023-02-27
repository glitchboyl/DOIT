import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/svg.dart';
import 'package:doit/models/navigation.dart';
import 'constants/styles.dart';
import 'constants/meas.dart';

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
      var page = navigation[i];
      _navigationBarItems.add(
        BottomNavigationBarItem(
          icon: svg(
            page.icon,
            width: MEAS.tabIconWidth,
            height: MEAS.tabIconHeight,
          ),
          activeIcon: svg(
            page.activeIcon,
            width: MEAS.tabIconWidth,
            height: MEAS.tabIconHeight,
          ),
          label: '',
        ),
      );
      _pageWidgets.add(page.widget());
    }
  }

  @override
  Widget build(context) {
    return ScreenUtilInit(
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
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: _navigationBarItems,
              backgroundColor: Styles.TabBarColor,
              currentIndex: _currentIndex,
              onTap: (int index) {
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
}
