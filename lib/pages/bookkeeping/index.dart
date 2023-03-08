import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final List<Widget> _widgets = [SizedBox(height: 20.h)];
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    buildWidgets();
  }

  void buildWidgets() {
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
    if (!initialized) {
      setState(() {});
    } else {
      initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        // margin: EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bookkeeping_bg.png'),
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 116.h, left: 16.w, right: 16.w),
                child: Container(
                  child: ListView.builder(
                    itemBuilder: (context, index) => _widgets[index],
                    itemCount: _widgets.length,
                  ),
                ),
              ),
            ),
            BookkeepingStatistics(incomes: 2000.8, expenses: 123.32),
          ],
        ),
      );
}
