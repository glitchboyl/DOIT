import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'schedule_to_do_list_title.dart';
import 'simple_to_do_item.dart';
import 'package:doit/models/schedule.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/utils/show_confirm_dialog.dart';
import 'package:doit/utils/time.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});
  @override
  _SchedulePageState createState() => _SchedulePageState();

  static final appBar = ({Key? key}) => SchedulePageAppBar(key: key);
}

class _SchedulePageState extends State<SchedulePage> {
  final List<Widget> _widgets = [];
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    buildWidgets();
  }

  void buildWidgets() {
    _widgets.removeRange(0, _widgets.length);
    scheduleToDoListMap.forEach((key, tdl) {
      if (tdl.list.length > 0) {
        _widgets.add(ScheduleToDoListTitle(
          tdl.title,
          key: ValueKey(key),
        ));
        for (int i = 0; i < tdl.list.length; i++) {
          _widgets.add(
            SimpleToDoItemWidget(
              tdl.list[i],
              onStatusChanged: () => onStatusChanged(tdl.list, i),
              onEdited: () => onEdited(tdl.list, i),
              onDeleted: () => onDeleted(tdl.list, i),
            ),
          );
        }
      }
    });
    if (!initialized) {
      setState(() {});
    } else {
      initialized = true;
    }
  }

  void onStatusChanged(List<ToDoItem> list, int index) {
    final ToDoItem tdi = list.removeAt(index);
    buildWidgets();
    Future.delayed(const Duration(milliseconds: 1), () {
      if (tdi.completeTime == null) {
        tdi.completeTime = DateTime.now();
        scheduleToDoListMap[ScheduleToDoListType.TodayCompleted]?.list.add(tdi);
      } else {
        tdi.completeTime = null;
        scheduleToDoListMap[tdi.startTime.isSameDay(nowTime)
                ? ScheduleToDoListType.TodayUncompleted
                : ScheduleToDoListType.PastUncompleted]
            ?.list
            .add(tdi);
      }
      buildWidgets();
    });
  }

  void onEdited(List<ToDoItem> list, int index) {}

  void onDeleted(List<ToDoItem> list, int index) {
    showConfirmDialog(
      context: context,
      content: '确定要删除"${list[index].title}"吗？',
      danger: true,
      onConfirm: (context) => {
        list.removeAt(index),
        Navigator.of(context).pop(),
        buildWidgets(),
        setState(() {}),
      },
    );
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: SlidableAutoCloseBehavior(
            child: ListView.builder(
              itemBuilder: (context, index) => _widgets[index],
              itemCount: _widgets.length,
            ),
          ),
        ),
      );
}
