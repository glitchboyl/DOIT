import 'package:flutter/material.dart';

abstract class Keys {
  static const Schedule = ValueKey('SCHEDULE');
  static const Overview = ValueKey('OVERVIEW');
  static const Notes = ValueKey('NOTES');
  static const Bookkeeping = ValueKey('BOOKKEEPING');

  static const PastUncompletedToDoList = ValueKey('PAST_UNCOMPLETED_TO_DO_LIST');
  static const TodayUncompletedToDoList = ValueKey('TODAY_UNCOMPLETED_TO_DO_LIST');
  static const TodayCompletedToDoList = ValueKey('TODAY_COMPLETED_TO_DO_LIST');

  static const AddToDoItemButton = ValueKey('ADD_TO_DO_ITEM_BUTTON');
}
