import 'package:flutter/material.dart';
import 'package:DO_IT/Today/TodayScreen.dart';
import 'package:DO_IT/utils/Adapt.dart';

void main() {
  runApp(DOITApp());
}

class DOITApp extends StatefulWidget {
  DOITApp({Key key}) : super(key: key);

  @override
  _DOITAppState createState() => _DOITAppState();
}

class _DOITAppState extends State<DOITApp> {
  int selected = 0;
  dynamic iconWidth = Adapt.px(150);
  dynamic iconHeight = Adapt.px(150);

  List<Widget> screens = [
    TodayScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DO IT',
      theme: ThemeData(
        primaryColor: Color(0xFF3A36EE),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: SafeArea(
          child: screens[selected],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          currentIndex: selected,
          onTap: (int index) {
            setState(() {
              selected = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF3A36EE),
          unselectedItemColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                'assets/navigation-bar/today.png',
                width: iconWidth,
                height: iconHeight,
              ),
              activeIcon: Image.asset(
                'assets/navigation-bar/today-actived.png',
                width: iconWidth,
                height: iconHeight,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                'assets/navigation-bar/plan.png',
                width: iconWidth,
                height: iconHeight,
              ),
              activeIcon: Image.asset(
                'assets/navigation-bar/plan-actived.png',
                width: iconWidth,
                height: iconHeight,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                'assets/navigation-bar/note.png',
                width: iconWidth,
                height: iconHeight,
              ),
              activeIcon: Image.asset(
                'assets/navigation-bar/note-actived.png',
                width: iconWidth,
                height: iconHeight,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                'assets/navigation-bar/settings.png',
                width: iconWidth,
                height: iconHeight,
              ),
              activeIcon: Image.asset(
                'assets/navigation-bar/settings-actived.png',
                width: iconWidth,
                height: iconHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
