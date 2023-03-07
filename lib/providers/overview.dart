import 'package:flutter/widgets.dart';

class OverviewProvider extends ChangeNotifier {
  late DateTime _focusDay;

  DateTime get focusDay => _focusDay;
}