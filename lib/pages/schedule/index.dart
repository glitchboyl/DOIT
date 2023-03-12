import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
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
  SchedulePage({super.key});

  final ItemScrollController _scrollController = ItemScrollController();
  final _positionsListener = ItemPositionsListener.create();
  int _freshWidgetIndex = 0;

  List<Widget> buildWidgets(
    BuildContext context,
    ToDoListProvider provider,
  ) {
    final List<Widget> _widgets = [];
    int index = 0;
    provider.scheduleToDoListMap.forEach(
      (type, tdl) {
        if (tdl.list.length > 0) {
          _widgets.add(
            ScheduleToDoListTitle(
              tdl.title,
              key: ValueKey(type),
            ),
          );
          index++;
          for (int i = 0; i < tdl.list.length; i++) {
            if (provider.fresh == tdl.list[i]) {
              _freshWidgetIndex = index;
            }
            _widgets.add(
              SimpleToDoItemWidget(
                tdl.list[i],
                onStatusChanged: (context) => onStatusChanged(context, type, i),
                onEdited: (context) => onEdited(context, tdl.list[i]),
                onDeleted: (context) => onDeleted(context, tdl.list[i]),
              ),
            );
            index++;
          }
        }
      },
    );
    _widgets.add(SizedBox(height: 10));
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
                final _widgets = buildWidgets(context, provider);
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

                return ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  itemPositionsListener: _positionsListener,
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
