import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'to_do_item.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/dashed_line.dart';
import 'package:doit/widgets/navigation_bar.dart';
import 'package:doit/widgets/add_to_do_item_button.dart';
import 'package:doit/widgets/svg.dart';
import 'package:doit/constants/colors.dart';
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
    return CupertinoPageScaffold(
      navigationBar: navigationBar(
        leading: navigationBarButton(
          'assets/images/quadrant.svg',
          () => {},
        ),
        middle: const Text(
          '10月',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'DIN',
          ),
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
            Container(
              width: 28.w,
              alignment: Alignment.center,
              child: dashedLine(),
            ),
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
      backgroundColor: Colors.GeneralBackgroundColor,
    );
  }
}
