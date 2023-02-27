import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'simple_to_do_item.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/add_to_do_item_button.dart';
import 'package:doit/widgets/svg.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class FirstTab extends StatefulWidget {
  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  List<ToDoItem> mockList = [
    ToDoItem(
      id: UniqueKey().hashCode,
      title: 'Hello world',
      type: ToDoItemType.Study,
      level: ToDoItemLevel.I,
      to: DateTime(2023, 2, 26),
      from: DateTime(2023, 2, 27),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        leading: appBarIconButton(
          'assets/images/menu.svg',
          () => {},
        ),
        title: const Text(
          'DO IT',
          style: const TextStyle(
            color: Styles.PrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: appBarIconButton(
          'assets/images/quadrant.svg',
          () => {},
        ),
      ),
      body: Padding(
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
                      (context, index) => SimpleToDoItemWidget(mockList[index]),
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
                      type: ToDoItemType.Work,
                      level: ToDoItemLevel.II,
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
