import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'to_do_item.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/add_to_do_item_button.dart';
import 'package:doit/styles.dart';

class SecondTab extends StatefulWidget {
  @override
  _SecondTabState createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  List<ToDoItem> mockList = [
    ToDoItem(
      id: UniqueKey().hashCode,
      title: 'Hello world',
      remarks: 'ass we can',
      type: ToDoItemType.a,
      status: ToDoItemStatus.a,
      to: DateTime(2023, 2, 26),
      from: DateTime(2023, 2, 27),
    ),
    ToDoItem(
      id: UniqueKey().hashCode,
      title: 'boy next doorrrrrr',
      type: ToDoItemType.a,
      status: ToDoItemStatus.a,
      to: DateTime(2023, 2, 26),
      from: DateTime(2023, 2, 27),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Styles.NavigatorBarColor,
        middle: const Text('10月'),
        border: Border(
          bottom: BorderSide(color: Styles.NavigatorBarColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          left: 24,
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
                        return ToDoItemWidget(mockList[index]);
                      },
                      childCount: mockList.length,
                    ),
                  ),
                ),
              ],
            ),
            addToDoItemButton(
              () => {
                // setState(() {
                //   mockList = [...mockList, 1];
                // });
              },
            ),
          ],
        ),
      ),
      backgroundColor: Styles.GeneralBackgroundColor,
    );
  }
}
