import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'to_do_item.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/dashed_line.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/add_to_do_item_button.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class SecondTab extends StatefulWidget {
  @override
  _SecondTabState createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  List<ToDoItem> mockList = [
    ToDoItem(
      id: UniqueKey().hashCode,
      title: '芜湖',
      remarks: '什么玩意',
      type: ToDoItemType.Life,
      level: ToDoItemLevel.IV,
    ),
    ToDoItem(
      id: UniqueKey().hashCode,
      title: '测试一下',
      type: ToDoItemType.Health,
      level: ToDoItemLevel.II,
      to: DateTime(2023, 2, 26),
      from: DateTime(2023, 2, 27),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        leading: appBarIconButton(
          'assets/images/view.svg',
          () => {},
        ),
        title: const Text(
          '10月',
          style: TextStyle(
            color: Styles.PrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          left: 24,
          right: 16,
        ),
        child: Stack(
          children: [
            Container(
              width: MEAS.toDoListTimelineContainerWidth,
              alignment: Alignment.center,
              child: dashedLine(),
            ),
            CustomScrollView(
              slivers: [
                SliverSafeArea(
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ToDoItemWidget(mockList[index]),
                      childCount: mockList.length,
                    ),
                  ),
                ),
              ],
            ),
            AddToDoItemButton(
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
