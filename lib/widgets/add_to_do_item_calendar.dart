import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'app_bar.dart';
import 'svg_icon.dart';
import 'svg_icon_button.dart';
import 'add_to_do_item_dialog_input.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class AddToDoItemCalendar extends StatefulWidget {
  const AddToDoItemCalendar({super.key});
  @override
  _AddToDoItemCalendarState createState() => _AddToDoItemCalendarState();
}

class _AddToDoItemCalendarState extends State<AddToDoItemCalendar> {
  @override
  Widget build(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppBarBuilder(
            title: Text(
              '添加日程',
              style: TextStyle(
                color: Styles.PrimaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: Styles.largeTextSize,
                height: Styles.largeTextLineHeight / Styles.largeTextSize,
              ),
            ),
            trailing: SVGIconButton(
              icon: 'assets/images/send.svg',
              onPressed: () => {},
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
          ),
        ],
      );
}
