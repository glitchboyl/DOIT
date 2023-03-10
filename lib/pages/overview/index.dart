import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/dashed_line.dart';
import 'app_bar.dart';
import 'to_do_item.dart';
import 'calendar_row.dart';
import 'calendar_view.dart';
import 'package:doit/widgets/to_do_item_dialog.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/show_confirm_dialog.dart';
import 'package:doit/models/overview.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/providers/to_do_list.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/keys.dart';

class OverviewPage extends StatelessWidget {
  OverviewPage({super.key});

  final _toDoListController = ScrollController();

  List<Widget> buildToDoList(BuildContext context, ToDoListProvider provider) {
    final List<Widget> toDoList = [SizedBox(height: 16)];
    (provider.overviewMap[provider.focusedDate] ?? []).forEach(
      (item) => toDoList.add(
        ToDoItemWidget(
          item,
          onStatusChanged: (context) =>
              onStatusChanged(context, provider, item),
          onEdited: (context) => onEdited(context, item),
          onDeleted: (context) => onDeleted(context, provider, item),
        ),
      ),
    );
    return toDoList;
  }

  void onStatusChanged(
    BuildContext context,
    ToDoListProvider provider,
    ToDoItem item,
  ) =>
      {
        item.completeTime = (item.completeTime == null ? DateTime.now() : null),
        provider.update(item),
      };

  void onEdited(BuildContext context, ToDoItem item) => showBottomDrawer(
        context: context,
        builder: (context) => ToDoItemDialog(
          item: item,
        ),
      );

  void onDeleted(
    BuildContext context,
    ToDoListProvider provider,
    ToDoItem item,
  ) =>
      showConfirmDialog(
        '确定要删除"${item.title}"吗？',
        context: context,
        danger: true,
        onConfirm: (context) => {
          provider.delete(item),
          Navigator.pop(context),
        },
      );

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Container(
          child: Consumer<ToDoListProvider>(
            builder: (context, provider, _) {
              if (provider.overviewMode == OverviewMode.Day) {
                final _toDoList = buildToDoList(context, provider);
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MEAS.calendarRowHeight,
                        left: 20,
                        right: 16,
                      ),
                      child: Stack(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: MEAS.toDoListTimelineContainerWidth,
                            height: MediaQuery.of(context).size.height,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(height: 16),
                                Expanded(
                                  child: DashedLine(),
                                ),
                              ],
                            ),
                          ),
                          SlidableAutoCloseBehavior(
                            child: ListView.builder(
                              itemBuilder: (context, index) => _toDoList[index],
                              itemCount: _toDoList.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CalendarRow(
                      key: Keys.calendarRow,
                    ),
                  ],
                );
              } else {
                return CalendarView();
              }
            },
          ),
        ),
      );

  static final appBar = ({Key? key}) => OverviewPageAppBar(key: key);
}
