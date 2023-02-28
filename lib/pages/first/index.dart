import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'simple_to_do_item.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/app_bar_icon_button.dart';
import 'package:doit/widgets/add_to_do_item_button.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/keys.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({Key? key}) : super(key: key);
  @override
  FirstTabState createState() => FirstTabState();
}

class FirstTabState extends State<FirstTab> {
  List<ToDoItem> mockList = [
    ToDoItem(
      id: UniqueKey(),
      title: 'Hello world',
      type: ToDoItemType.Study,
      level: ToDoItemLevel.I,
      to: DateTime(2023, 2, 26),
      from: DateTime(2023, 2, 27),
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        key: Keys.First,
        appBar: AppBarBuilder(
          leading: AppBarIconButton(
            icon: 'assets/images/menu.svg',
            onPressed: () => {},
          ),
          title: Text(
            'DO IT',
            style: TextStyle(
              color: Styles.TextColor,
              fontWeight: FontWeight.bold,
              fontSize: MEAS.largeTextSize,
              height: MEAS.largeTextLineHeight / MEAS.largeTextSize,
            ),
          ),
          trailing: AppBarIconButton(
            icon: 'assets/images/quadrant.svg',
            onPressed: () => {},
          ),
        ),
        body: Padding(
          key: Keys.First,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: CustomScrollView(
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
        ),
        resizeToAvoidBottomInset: false,
      );
}
