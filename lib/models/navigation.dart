import 'package:flutter/material.dart';
import 'package:doit/pages/schedule/index.dart';
import 'package:doit/pages/overview/index.dart';
import 'package:doit/pages/notes/index.dart';
import 'package:doit/pages/bookkeeping/index.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/constants/keys.dart';

class Navigation {
  const Navigation({
    required this.id,
    required this.icon,
    required this.activeIcon,
    required this.appBar,
    required this.widget,
  });

  final Key id;
  final String icon;
  final String activeIcon;
  final AppBarBuilder Function() appBar;
  final Widget Function() widget;
}

List<Navigation> navigation = [
  Navigation(
    id: Keys.SchedulePage,
    icon: 'assets/images/schedule.svg',
    activeIcon: 'assets/images/schedule_actived.svg',
    appBar: () => SchedulePage.appBar(key: Keys.SchedulePage),
    widget: () => SchedulePage(key: Keys.SchedulePage),
  ),
  Navigation(
    id: Keys.OverviewPage,
    icon: 'assets/images/overview.svg',
    activeIcon: 'assets/images/overview_actived.svg',
    appBar: () => OverviewPage.appBar(key: Keys.OverviewPage),
    widget: () => OverviewPage(key: Keys.OverviewPage),
  ),
  Navigation(
    id: Keys.NotesPage,
    icon: 'assets/images/notes.svg',
    activeIcon: 'assets/images/notes_actived.svg',
    appBar: () => NotesPage.appBar(key: Keys.NotesPage),
    widget: () => NotesPage(key: Keys.NotesPage),
  ),
  Navigation(
    id: Keys.BookkeepingPage,
    icon: 'assets/images/bookkeeping.svg',
    activeIcon: 'assets/images/bookkeeping_actived.svg',
    appBar: () => BookkeepingPage.appBar(key: Keys.OverviewPage),
    widget: () => BookkeepingPage(key: Keys.BookkeepingPage),
  ),
];