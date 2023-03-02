import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'simple_to_do_list_title.dart';
import 'simple_to_do_item.dart';
import 'package:doit/models/to_do_list.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/utils/show_confirm_dialog.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/keys.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);
  @override
  SchedulePageState createState() => SchedulePageState();

  static final appBar = ({Key? key}) => SchedulePageAppBar(key: key);
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

  @override
  void initState() {
    super.initState();
  }

  getWidgets() {
    final List<Widget> widgets = [];
    toDoLists.forEach((key, tdl) {
      if (tdl.list.length > 0) {
        widgets.add(
          SimpleToDoListTitle(tdl.title),
        );
        widgets.add(
          SliverList(
            key: key,
            delegate: SliverChildBuilderDelegate(
              (context, index) => SimpleToDoItemWidget(tdl.list[index],
                  onCompleted: () => onCompleted(tdl.list, index),
                  onResumed: () => onResumed(tdl.list, index),
                  onDismissed: () => onDismissed(tdl.list, index)),
              childCount: tdl.list.length,
            ),
          ),
        );
      }
    });
    return widgets;
  }

  void onCompleted(List<ToDoItem> list, int index) {
    final ToDoItem tdi = list.removeAt(index);
    tdi.completeTime = DateTime.now();
    toDoLists[Keys.TodayCompletedToDoList]?.list.add(tdi);
    setState(() {});
  }

  void onResumed(List<ToDoItem> list, int index) {
    final ToDoItem tdi = list.removeAt(index);
    tdi.completeTime = null;
    toDoLists[tdi.startTime.isSameDay(nowTime)
            ? Keys.TodayUncompletedToDoList
            : Keys.PastUncompletedToDoList]
        ?.list
        .add(tdi);
    setState(() {});
  }

  void onDismissed(List<ToDoItem> list, int index) {
    final ToDoItem tdi = list[index];
    showConfirmDialog(
      context: context,
      content: '确定要删除"${tdi.title}"吗？',
      danger: true,
      onConfirm: (context) => {
        list.remove(tdi),
        Navigator.of(context).pop(),
        setState(() {}),
      },
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: SlidableAutoCloseBehavior(
          child: CustomScrollView(
            slivers: getWidgets(),
          ),
        ),
      );
}
