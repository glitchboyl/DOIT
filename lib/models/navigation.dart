import 'package:flutter/material.dart';
import 'package:doit/pages/schedule/index.dart';
import 'package:doit/pages/overview/index.dart';
import 'package:doit/pages/notes/index.dart';
import 'package:doit/pages/bookkeeping/index.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/constants/icons.dart';
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
  final String Function(BuildContext) icon;
  final String Function(BuildContext) activeIcon;
  final AppBarBuilder Function() appBar;
  final Widget Function() widget;
}

List<Navigation> navigation = [
  Navigation(
    id: Keys.SchedulePage,
    icon: (context) => Theme.of(context).brightness == Brightness.dark
        ? Ico.ScheduleDark
        : Ico.Schedule,
    activeIcon: (context) => Theme.of(context).brightness == Brightness.dark
        ? Ico.ScheduleActivedDark
        : Ico.ScheduleActived,
    appBar: () => SchedulePage.appBar(key: Keys.SchedulePage),
    widget: () => SchedulePage(key: Keys.SchedulePage),
  ),
  Navigation(
    id: Keys.OverviewPage,
    icon: (context) => Theme.of(context).brightness == Brightness.dark
        ? Ico.OverviewDark
        : Ico.Overview,
    activeIcon: (context) => Theme.of(context).brightness == Brightness.dark
        ? Ico.OverviewActivedDark
        : Ico.OverviewActived,
    appBar: () => OverviewPage.appBar(key: Keys.OverviewPage),
    widget: () => OverviewPage(key: Keys.OverviewPage),
  ),
  Navigation(
    id: Keys.NotesPage,
    icon: (context) => Theme.of(context).brightness == Brightness.dark
        ? Ico.NotesDark
        : Ico.Notes,
    activeIcon: (context) => Theme.of(context).brightness == Brightness.dark
        ? Ico.NotesActivedDark
        : Ico.NotesActived,
    appBar: () => NotesPage.appBar(key: Keys.NotesPage),
    widget: () => NotesPage(key: Keys.NotesPage),
  ),
  Navigation(
    id: Keys.BookkeepingPage,
    icon: (context) => Theme.of(context).brightness == Brightness.dark
        ? Ico.BookkeepingDark
        : Ico.Bookkeeping,
    activeIcon: (context) => Theme.of(context).brightness == Brightness.dark
        ? Ico.BookkeepingActivedDark
        : Ico.BookkeepingActived,
    appBar: () => BookkeepingPage.appBar(key: Keys.OverviewPage),
    widget: () => BookkeepingPage(key: Keys.BookkeepingPage),
  ),
];
