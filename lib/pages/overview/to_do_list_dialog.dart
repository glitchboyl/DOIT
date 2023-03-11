import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/simple_to_do_item.dart';
import 'package:doit/widgets/to_do_item_dialog.dart';
import 'package:doit/widgets/interactive_button.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/providers/to_do_list.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/show_confirm_dialog.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/calendar.dart';

class ToDoListDialog extends StatelessWidget {
  const ToDoListDialog({
    super.key,
  });

  List<Widget> buildWidgets(
    BuildContext context,
    ToDoListProvider provider,
  ) {
    final List<Widget> _widgets = [];
    final toDoList = provider.overviewMap[provider.focusedDate] ?? [];
    for (int i = 0; i < toDoList.length; i++) {
      _widgets.add(
        SimpleToDoItemWidget(
          toDoList[i],
          onStatusChanged: (context) => onStatusChanged(provider, toDoList[i]),
          onEdited: (context) => onEdited(context, toDoList[i]),
          onDeleted: (context) => onDeleted(context, provider, toDoList[i]),
          leftActionDismissible: false,
        ),
      );
    }
    _widgets.add(SizedBox(height: 10));
    return _widgets;
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
          Navigator.pop(context),
        },
      );

  @override
  Widget build(context) {
    final _provider = Provider.of<ToDoListProvider>(context);
    return Wrap(
      children: [
        AppBarBuilder(
          title: TextBuilder(
            '${getDateTime(_provider.focusedDate)} 周${weekDayTextMap[_provider.focusedDate.weekday]}',
            color: Styles.PrimaryTextColor,
            fontSize: Styles.largeTextSize,
            lineHeight: Styles.largeTextLineHeight,
            fontWeight: FontWeight.bold,
          ),
          trailings: [
            InteractiveButton(
              width: 32,
              height: 32,
              color: Styles.PrimaryColor,
              activedColor: Styles.PrimaryDeepColor,
              shadowColor: Styles.AddButtonShadowColor,
              elevation: 0,
              shape: const CircleBorder(),
              child: SVGIcon(
                'assets/images/add.svg',
                color: Styles.RegularBaseColor,
                width: MEAS.itemOperationIconLength,
                height: MEAS.itemOperationIconLength,
              ),
              onPressed: () => showBottomDrawer(
                context: context,
                builder: (context) => ToDoItemDialog(),
              ),
            ),
            SizedBox.shrink(),
          ],
        ),
        Container(
          height: 400,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SlidableAutoCloseBehavior(
            child: Consumer<ToDoListProvider>(
              builder: (context, provider, _) {
                final _widgets = buildWidgets(context, provider);
                return ListView.builder(
                  itemBuilder: (context, index) => _widgets[index],
                  itemCount: _widgets.length,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}