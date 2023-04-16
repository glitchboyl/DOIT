import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/dashed_line.dart';
import 'app_bar.dart';
import 'to_do_item.dart';
import 'calendar_row.dart';
import 'calendar_view.dart';
import 'package:doit/widgets/to_do_item_dialog.dart';
import 'package:doit/widgets/blank.dart';
import 'package:doit/utils/toast.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/show_confirm_dialog.dart';
import 'package:doit/models/overview.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/providers/to_do_list.dart';
import 'package:doit/providers/theme.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/keys.dart';

class OverviewPage extends StatelessWidget {
  OverviewPage({super.key});

  final ItemScrollController _scrollController = ItemScrollController();
  final _positionsListener = ItemPositionsListener.create();
  int _freshWidgetIndex = 0;

  List<Widget> buildToDoList(BuildContext context, ToDoListProvider provider) {
    final List<Widget> toDoList = [SizedBox(height: 16)];
    int index = 1;
    (provider.overviewMap[provider.focusedDate] ?? []).forEach(
      (item) {
        if (provider.fresh == item) {
          _freshWidgetIndex = index;
        }
        toDoList.add(
          ToDoItemWidget(
            item,
            onStatusChanged: (context) => onStatusChanged(provider, item),
            onEdited: (context) => onEdited(context, item),
            onDeleted: (context) => onDeleted(context, provider, item),
          ),
        );
        index++;
      },
    );
    return toDoList;
  }

  void onStatusChanged(
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
          Future.delayed(
            const Duration(milliseconds: 100),
            () => Toast.show(
              context,
              text: '删除成功',
            ),
          ),
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
                if (provider.fresh != null) {
                  Future.delayed(
                    const Duration(milliseconds: 1),
                    () {
                      final _itemPositions =
                          _positionsListener.itemPositions.value.toList();
                      if (_itemPositions.first.index > _freshWidgetIndex ||
                          _itemPositions.last.index < _freshWidgetIndex) {
                        _scrollController.jumpTo(
                          index: _freshWidgetIndex,
                        );
                      }
                      provider.refresh();
                    },
                  );
                }
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MEAS.calendarRowHeight,
                        left: 16,
                        right: 16,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 20) / 7 -
                                    12,
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
                          _toDoList.length == 1
                              ? Blank(
                                  '没有安排就是最好的安排',
                                  isDarkMode(context)
                                      ? Ico.ScheduleBlankDark
                                      : Ico.ScheduleBlank,
                                )
                              : SlidableAutoCloseBehavior(
                                  child: ScrollablePositionedList.builder(
                                    itemScrollController: _scrollController,
                                    itemPositionsListener: _positionsListener,
                                    itemBuilder: (context, index) =>
                                        _toDoList[index],
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
                return CalendarView(
                  key: Keys.calendarView,
                );
              }
            },
          ),
        ),
      );

  static final appBar = ({Key? key}) => OverviewPageAppBar(key: key);
}
