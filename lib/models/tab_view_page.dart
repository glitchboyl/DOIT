import 'package:flutter/cupertino.dart';

class TabViewPage {
  const TabViewPage({
    required this.tabIcon,
    required this.tabActiveIcon,
    required this.viewWidget,
    required this.name,
    required this.path,
  });

  final String tabIcon;
  final String tabActiveIcon;
  final Widget Function(BuildContext) viewWidget;
  final String name;
  final String path;
}