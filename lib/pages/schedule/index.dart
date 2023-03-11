import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'schedule_to_do_list_title.dart';
import 'package:doit/widgets/to_do_item_dialog.dart';
import 'package:doit/widgets/simple_to_do_item.dart';
import 'package:doit/providers/to_do_list.dart';
import 'package:doit/models/schedule.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/utils/show_confirm_dialog.dart';
import 'package:doit/utils/show_bottom_drawer.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  List<Widget> buildWidgets(
    BuildContext context,
    Map<ScheduleToDoListType, ScheduleToDoList> map,
  ) {
    final List<Widget> _widgets = [];
    map.forEach(
      (type, tdl) {
        if (tdl.list.length > 0) {
          _widgets.add(
            ScheduleToDoListTitle(
              tdl.title,
              key: ValueKey(type),
            ),
          );
          for (int i = 0; i < tdl.list.length; i++) {
            _widgets.add(
              SimpleToDoItemWidget(
                tdl.list[i],
                onStatusChanged: (context) => onStatusChanged(context, type, i),
                onEdited: (context) => onEdited(context, tdl.list[i]),
                onDeleted: (context) => onDeleted(context, tdl.list[i]),
              ),
            );
          }
        }
      },
    );
    return _widgets;
  }

  ToDoListProvider getProvider(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<ToDoListProvider>(
        context,
        listen: listen,
      );

  void onStatusChanged(
    BuildContext context,
    ScheduleToDoListType type,
    int index,
  ) =>
      getProvider(context, listen: false)
          .changeScheduleToDoItemStatus(type, index);

  void onEdited(BuildContext context, ToDoItem item) => showBottomDrawer(
        context: context,
        builder: (context) => ToDoItemDialog(
          item: item,
        ),
      );

  void onDeleted(BuildContext context, ToDoItem item) {
    final provider = getProvider(context, listen: false);
    showConfirmDialog(
      '确定要删除"${item.title}"吗？',
      context: context,
      danger: true,
      onConfirm: (context) => {
        provider.delete(item),
        Navigator.pop(context),
      },
    );
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SlidableAutoCloseBehavior(
            child: Consumer<ToDoListProvider>(
              builder: (context, provider, _) {
                final _widgets =
                    buildWidgets(context, provider.scheduleToDoListMap);
                return ListView.builder(
                  itemBuilder: (context, index) => _widgets[index],
                  itemCount: _widgets.length,
                );
              },
            ),
          ),
        ),
      );

  static final appBar = ({Key? key}) => SchedulePageAppBar(key: key);
}
