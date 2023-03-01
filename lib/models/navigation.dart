import 'package:flutter/material.dart';
import 'package:doit/pages/schedule/index.dart';
import 'package:doit/pages/overview/index.dart';
import 'package:doit/pages/notes/index.dart';
import 'package:doit/pages/bookkeeping/index.dart';
import 'package:doit/constants/keys.dart';

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
    name: Keys.Schedule.toString(),
    icon: 'assets/images/schedule.svg',
    activeIcon: 'assets/images/schedule_actived.svg',
    widget: () => SchedulePage(key: Keys.Schedule),
  ),
  Navigation(
    name: Keys.Overview.toString(),
    icon: 'assets/images/overview.svg',
    activeIcon: 'assets/images/overview_actived.svg',
    widget: () => OverviewPage(key: Keys.Overview),
  ),
  Navigation(
    name: Keys.Notes.toString(),
    icon: 'assets/images/notes.svg',
    activeIcon: 'assets/images/notes_actived.svg',
    widget: () => NotesPage(key: Keys.Notes),
  ),
  Navigation(
    name: Keys.Bookkeeping.toString(),
    icon: 'assets/images/bookkeeping.svg',
    activeIcon: 'assets/images/bookkeeping_actived.svg',
    widget: () => BookkeepingPage(key: Keys.Bookkeeping),
  ),
];
