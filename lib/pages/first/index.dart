import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'to_do_item.dart';
import 'package:doit/styles.dart';

class FirstTab extends StatefulWidget {
  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  List mockList = [];

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
                        return ToDoItem(
                          'Mock $index',
                          to: DateTime(2023, 2, 26),
                          from: DateTime(2023, 2, 27),
                        );
                      },
                      childCount: mockList.length,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 48,
              child: Container(
                width: 52,
                height: 52,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: CupertinoColors.black,
                  //     offset: Offset(0.0, 6.0), //阴影y轴偏移量
                  //     blurRadius: 0, //阴影模糊程度
                  //     spreadRadius: 0, //阴影扩散程度
                  //   ),
                  // ],
                ),
                child: CupertinoButton(
                  color: Styles.FirstPageButtonColor,
                  padding: EdgeInsets.zero,
                  pressedOpacity: 0.8,
                  child: const Text('+', style: TextStyle(fontSize: 32)),
                  onPressed: () {
                    setState(() {
                      mockList = [...mockList, 1];
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Styles.GeneralBackgroundColor,
    );
  }
}
