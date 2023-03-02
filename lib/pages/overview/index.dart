import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/dashed_line.dart';
import 'app_bar.dart';
import 'to_do_item.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/constants/meas.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});
  @override
  _OverviewPageState createState() => _OverviewPageState();

  static final appBar = ({Key? key}) => OverviewPageAppBar(key: key);
}

class _OverviewPageState extends State<OverviewPage> {
  List<ToDoItem> mockList = [
    ToDoItem(
      id: UniqueKey(),
      title: '芜湖',
      remarks: '什么玩意',
      type: ToDoItemType.Life,
      level: ToDoItemLevel.IV,
      startTime: DateTime(2023, 2, 26),
      endTime: DateTime(2023, 2, 27),
    ),
    ToDoItem(
      id: UniqueKey(),
      title: '测试一下',
      type: ToDoItemType.Health,
      level: ToDoItemLevel.II,
      startTime: DateTime(2023, 2, 26),
      endTime: DateTime(2023, 2, 27),
    )
  ];

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: 12.h,
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
      );
}
