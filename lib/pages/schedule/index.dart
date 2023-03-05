import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'schedule_to_do_list_title.dart';
import 'simple_to_do_item.dart';
import 'package:doit/providers/to_do_list.dart';
import 'package:doit/models/schedule.dart';
import 'package:doit/models/to_do_list.dart';
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
  List<Widget> buildWidgets(BuildContext context) {
    final List<Widget> _widgets = [];
    Provider.of<ToDoListProvider>(
      context,
      listen: false,
    ).scheduleToDoListMap.forEach((type, tdl) {
      if (tdl.list.length > 0) {
        _widgets.add(ScheduleToDoListTitle(
          tdl.title,
          key: ValueKey(type),
        ));
        for (int i = 0; i < tdl.list.length; i++) {
          _widgets.add(
            SimpleToDoItemWidget(
              tdl.list[i],
              onStatusChanged: (context) => onStatusChanged(context, type, i),
              onEdited: (context) => onEdited(context, type, i),
              onDeleted: (context) => onDeleted(context, type, i),
            ),
          );
        }
      }
    });
    return _widgets;
  }

  ToDoListProvider getProvider(BuildContext context, {bool listen = true}) =>
      Provider.of<ToDoListProvider>(
        context,
        listen: listen,
      );

  void onStatusChanged(
          BuildContext context, ScheduleToDoListType type, int index) =>
      getProvider(context, listen: false).updateSchedule(type, index);

  void onEdited(BuildContext context, ScheduleToDoListType type, int index) {}

  void onDeleted(BuildContext context, ScheduleToDoListType type, int index) {
    final provider = getProvider(context, listen: false);
    showConfirmDialog(
      context: context,
      content:
          '确定要删除"${provider.scheduleToDoListMap[type]!.list[index].title}"吗？',
      danger: true,
      onConfirm: (context) => {
        provider.deleteSchedule(type, index),
        Navigator.of(context).pop(),
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
            child: Consumer<ToDoListProvider>(
              builder: (context, provider, _) {
                final _widgets = buildWidgets(context);
                return ListView.builder(
                  itemBuilder: (context, index) => _widgets[index],
                  itemCount: _widgets.length,
                );
              },
            ),
          ),
        ),
      );
}
