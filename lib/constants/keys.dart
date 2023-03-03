import 'package:flutter/material.dart';

abstract class Keys {
  static const SchedulePage = ValueKey('SCHEDULE_PAGE');
  static const OverviewPage = ValueKey('OVERVIEW_PAGE');
  static const NotesPage = ValueKey('NOTES_PAGE');
  static const BookkeepingPage = ValueKey('BOOKKEEPING_PAGE');

  static const NotePage = ValueKey('NOTE_PAGE');
  static const NotePublishingPage = ValueKey('NOTE_PUBLISHING_PAGE');

  static const AddButton = ValueKey('ADD_BUTTON');

  static const PastUncompletedToDoList = ValueKey('PAST_UNCOMPLETED_TO_DO_LIST');
  static const TodayUncompletedToDoList = ValueKey('TODAY_UNCOMPLETED_TO_DO_LIST');
  static const TodayCompletedToDoList = ValueKey('TODAY_COMPLETED_TO_DO_LIST');

  // static const DrawerItemAllSchedule = ValueKey('DRAWER_ITEM_ALL_SCHEDULE');
}
