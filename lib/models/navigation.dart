import 'package:flutter/material.dart';
import 'package:doit/pages/first/index.dart';
import 'package:doit/pages/second/index.dart';
import 'package:doit/pages/third/index.dart';
import 'package:doit/pages/fourth/index.dart';

class Navigation {
  const Navigation({
    required this.name,
    required this.icon,
    required this.activeIcon,
    required this.widget,
  });

  final String name;
  final String icon;
  final String activeIcon;
  final Widget Function() widget;
}

List<Navigation> navigation = [
  Navigation(
    name: 'First',
    icon: 'assets/images/first.svg',
    activeIcon: 'assets/images/first_actived.svg',
    widget: () => FirstTab(),
  ),
  Navigation(
    name: 'Second',
    icon: 'assets/images/second.svg',
    activeIcon: 'assets/images/second_actived.svg',
    widget: () => SecondTab(),
  ),
  Navigation(
    name: 'Third',
    icon: 'assets/images/third.svg',
    activeIcon: 'assets/images/third_actived.svg',
    widget: () => ThirdTab(),
  ),
  Navigation(
    name: 'Fourth',
    icon: 'assets/images/third.svg',
    activeIcon: 'assets/images/third_actived.svg',
    widget: () => FourthTab(),
  ),
];
