import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_bar.dart';
import 'bookkeeping_statistics.dart';
import 'bookkeeping_list_title.dart';
import 'bookkeeping_item.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingPage extends StatefulWidget {
  const BookkeepingPage({super.key});
  @override
  _BookkeepingPageState createState() => _BookkeepingPageState();

  static final appBar = ({Key? key}) => BookkeepingPageAppBar(key: key);
}

class _BookkeepingPageState extends State<BookkeepingPage> {
  final mockList = [];
  final _widgets = [];
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    buildWidgets();
  }

  void buildWidgets() {
    _widgets.removeRange(0, _widgets.length);
    bookkeepingMap.forEach((date, list) {
      _widgets.add(
        BookkeepingListTitle(
          date.isSameDay(nowTime) ? '今天' : getDateTime(date),
          key: ValueKey(date),
          incomes: 100,
          expenses: 100,
        ),
      );
      for (int i = 0; i < list.length; i++) {
        _widgets.add(
          BookkeepingItemWidget(
            list[i],
            // date.isSameDay(nowTime) ? '今天' : getDateTime(date),
            // key: ValueKey(date),
            // incomes: 100,
            // expenses: 100,
          ),
        );
      }
    });
    // _widgets.add();
    // scheduleToDoListMap.forEach((key, tdl) {
    //   if (tdl.list.length > 0) {
    //     _widgets.add(ScheduleToDoListTitle(
    //       tdl.title,
    //       key: ValueKey(key),
    //     ));
    //     for (int i = 0; i < tdl.list.length; i++) {
    //       _widgets.add(
    //         SimpleToDoItemWidget(
    //           tdl.list[i],
    //           key: tdl.list[i].id,
    //           leftAction: () => leftAction(tdl.list, i),
    //           rightAction: () => rightAction(tdl.list, i),
    //         ),
    //       );
    //     }
    //   }
    // });
    // if (!initialized) {
    //   setState(() {});
    // } else {
    //   initialized = true;
    // }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Container(
                margin: EdgeInsets.only(top: 120.h),
                child: ListView.builder(
                  itemBuilder: (context, index) => _widgets[index],
                  itemCount: _widgets.length,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 182.h,
              child: SvgPicture.asset(
                'assets/images/bookkeeping_bg.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          BookkeepingStatistics(incomes: 2000.8, expenses: 123.32),
        ],
      );
}
