import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'to_do_item.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/dashed_line.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/app_bar_icon_button.dart';
import 'package:doit/widgets/add_to_do_item_button.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/keys.dart';

class SecondTab extends StatefulWidget {
  @override
  SecondTabState createState() => SecondTabState();
}

class SecondTabState extends State<SecondTab> {
  List<ToDoItem> mockList = [
    ToDoItem(
      id: UniqueKey(),
      title: '芜湖',
      remarks: '什么玩意',
      type: ToDoItemType.Life,
      level: ToDoItemLevel.IV,
    ),
    ToDoItem(
      id: UniqueKey(),
      title: '测试一下',
      type: ToDoItemType.Health,
      level: ToDoItemLevel.II,
      to: DateTime(2023, 2, 26),
      from: DateTime(2023, 2, 27),
    )
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        key: Keys.Second,
        appBar: AppBarBuilder(
          leading: AppBarIconButton(
            icon: 'assets/images/view.svg',
            onPressed: () => {},
          ),
          title: Text(
            '10月',
            style: TextStyle(
              color: Styles.TextColor,
              fontWeight: FontWeight.bold,
              fontSize: MEAS.largeTextSize,
              height: MEAS.largeTextLineHeight / MEAS.largeTextSize,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: 12.w,
            left: 24.w,
            right: 16.w,
          ),
          child: Stack(
            children: [
              Container(
                width: MEAS.toDoListTimelineContainerWidth,
                alignment: Alignment.center,
                child: DashedLine(),
              ),
              CustomScrollView(
                slivers: [
                  SliverSafeArea(
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ToDoItemWidget(
                          mockList[index],
                        ),
                        childCount: mockList.length,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
      );
}
