import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'simple_to_do_list_title.dart';
import 'simple_to_do_item.dart';
import 'package:doit/models/to_do_list.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/keys.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);
  @override
  SchedulePageState createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  final Map<ValueKey<String>, ToDoList> toDoLists = {
    Keys.PastUncompletedToDoList: ToDoList(
      title: '过去',
      list: [
        ToDoItem(
          id: UniqueKey(),
          title: '健身计划开始。',
          type: ToDoItemType.Life,
          level: ToDoItemLevel.I,
          startTime: DateTime(2022, 7, 10, 19),
          endTime: DateTime(2022, 7, 10, 19),
        )
      ],
    ),
    Keys.TodayUncompletedToDoList: ToDoList(
      title: '今天',
      list: [
        ToDoItem(
          id: UniqueKey(),
          title: '看书看书看书!!!',
          type: ToDoItemType.Study,
          level: ToDoItemLevel.II,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          repeatType: RepeatType.EveryDay,
        ),
        ToDoItem(
          id: UniqueKey(),
          title: '记得写实习报告!!!!',
          type: ToDoItemType.Study,
          level: ToDoItemLevel.I,
          startTime: DateTime(2023, 2, 10, 9),
          endTime: DateTime(2023, 2, 17, 9),
        )
      ],
    ),
    Keys.TodayCompletedToDoList: ToDoList(
      title: '已完成',
      list: [
        ToDoItem(
          id: UniqueKey(),
          title: '整理需求文档',
          type: ToDoItemType.Study,
          level: ToDoItemLevel.II,
          startTime: DateTime(2023, 3, 2, 8),
          endTime: DateTime(2023, 3, 2, 8),
          completeTime: DateTime.now(),
        )
      ],
    ),
  };
  final List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    toDoLists.forEach((key, tdl) {
      if (tdl.list.length > 0) {
        widgets.add(
          SimpleToDoListTitle(tdl.title),
        );
        widgets.add(
          SliverList(
            key: key,
            delegate: SliverChildBuilderDelegate(
              (context, index) => SimpleToDoItemWidget(
                tdl.list[index],
                onCompleted: () => {},
                onResumed: () => {},
                onDismissed: () => {
                  tdl.list.removeAt(index),
                  setState(() {}),
                },
              ),
              childCount: tdl.list.length,
            ),
          ),
        );
      }
    });
  }

  void onCompleted(List<ToDoItem> list, int index) => {};

  void onResumed(List<ToDoItem> list, int index) => {};

  void onDismissed(List<ToDoItem> list, int index) => {
        list.removeAt(index),
        setState(() {}),
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarBuilder(
          leading: SVGIconButton(
            icon: 'assets/images/menu.svg',
            onPressed: () => {},
          ),
          title: Text(
            'DO IT',
            style: TextStyle(
              color: Styles.PrimaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: MEAS.largeTextSize,
              height: MEAS.largeTextLineHeight / MEAS.largeTextSize,
            ),
          ),
          trailing: SVGIconButton(
            icon: 'assets/images/quadrant.svg',
            onPressed: () => {},
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: CustomScrollView(slivers: widgets),
        ),
        resizeToAvoidBottomInset: false,
      );
}
