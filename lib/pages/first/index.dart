import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'simple_to_do_item.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/add_to_do_item_button.dart';
import 'package:doit/styles.dart';

class FirstTab extends StatefulWidget {
  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  List<ToDoItem> mockList = [
    ToDoItem(
      id: UniqueKey().hashCode,
      title: 'Hello world',
      type: ToDoItemType.a,
      status: ToDoItemStatus.a,
      to: DateTime(2023, 2, 26),
      from: DateTime(2023, 2, 27),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Styles.NavigatorBarColor,
        middle: const Text('聚焦'),
        border: Border(
          bottom: BorderSide(color: Styles.NavigatorBarColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverSafeArea(
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return SimpleToDoItemWidget(mockList[index]);
                      },
                      childCount: mockList.length,
                    ),
                  ),
                ),
              ],
            ),
            AddToDoItemButton(
              () => {
                setState(() {
                  mockList = [
                    ...mockList,
                    ToDoItem(
                      id: UniqueKey().hashCode,
                      title: 'ass we can',
                      type: ToDoItemType.a,
                      status: ToDoItemStatus.a,
                      to: DateTime(2023, 2, 26),
                      from: DateTime(2023, 2, 27),
                    )
                  ];
                })
              },
            ),
          ],
        ),
      ),
      backgroundColor: Styles.GeneralBackgroundColor,
    );
  }
}
